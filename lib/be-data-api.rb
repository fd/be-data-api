require "be-data-api/version"
require 'multi_json'
require 'excon'

module Be
  module Data
    class Api

      def initialize(api_id, api_key)
        @conn = Excon.new("https://api.data.be", :query => { "api_id" => api_id, "api_key" => api_key })
      end

      # API DOC: http://api.data.be/#validity
      # @example
      #   Be::Data::Api.new(...).vat_valid? "844044609"
      #   Be::Data::Api.new(...).vat_valid? "0844.044.609"
      #   Be::Data::Api.new(...).vat_valid? "BE-0844-044-609"
      def vat_valid?(vat_number)
        response = get("/1.0/vat/#{vat_number}/validity")
        p response
        return !!response["valid"]
      end

      # API DOC: http://api.data.be/#status
      # @example
      #   Be::Data::Api.new(...).vat_status "844044609"
      #   Be::Data::Api.new(...).vat_status "0844.044.609"
      #   Be::Data::Api.new(...).vat_status "BE-0844-044-609"
      def vat_status(vat_number)
        response = get("/1.0/vat/#{vat_number}/status")
        return VatStatus.new(response['vat-clean'], response['vat-formatted'], !!response['active'], !!response['valid'])
      end
      class VatStatus < Struct.new(:vat_clean, :vat_formatted, :active, :valid) ; end

      # API DOC: http://api.data.be/#basic
      # @example
      #   Be::Data::Api.new(...).vat_status "844044609"
      #   Be::Data::Api.new(...).vat_status "0844.044.609"
      #   Be::Data::Api.new(...).vat_status "BE-0844-044-609"
      def vat_basic(vat_number)
        response = get("/1.0/vat/#{vat_number}/basic")
        return VatBasic.new(response['vat-clean'], response['vat-formatted'], !!response['active'], !!response['valid'],
                            response['company-name'], response['start-date'], response['language'], response['address-fr'],
                            response['address-nl'])
      end
      class VatBasic < Struct.new(:vat_clean, :vat_formatted, :active, :valid, :company_name, :start_date, :language, :address_fr, :address_nl)
      end

    private

      def get(path)
        response = @conn.get(:path => path)
        response = MultiJson.decode(response.body)
        if response['success'] == true
          return response['data']
        else
          raise "Be::Data::Api.call failed: #{response.inspect}"
        end
      end

    end
  end
end
