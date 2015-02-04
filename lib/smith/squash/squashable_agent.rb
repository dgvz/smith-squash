require 'squash/ruby'

module Smith
  module Squash
    module SquashableAgent

      # Enable squash logging of any uncaught exception that results in the agent
      # dying.
      def enable_squash
        if use_squash?
          ::Squash::Ruby.configure(squash_config_options)

          on_exception do |exception|
            ::Squash::Ruby.notify(exception, :class => self.class)
          end
        end
      end

      # Send an aribtrary exception to squash.
      #
      # @param error [Exception] the exception to notify squash about
      # @param additional_data [Hash] some additional meta data to send with the
      #   exception
      def squash_notify(exception, additional_data = {})
        if use_squash?
          ::Squash::Ruby.configure(squash_config_options)

          # Little hack since squash doesn't allow the sending of exceptions
          # without a backtrace.
          unless exception.backtrace
            begin
              raise exception
            rescue ::Exception => ex
              exception = ex
            end
          end

          ::Squash::Ruby.notify(exception, additional_data.merge(:class => self.class))
        end
      end

      private

      def use_squash?
        squash_host && squash_api_key
      end

      def squash_host
        ENV["SQUASH_URI"]
      end

      def squash_api_key
        ENV["SQUASH_API_KEY"]
      end

      def skip_ssl_verification?
        ENV["SQUASH_SKIP_SSL_VERIFICATION"].to_s == "true"
      end

      def revision_file_path
        ENV["REVISION_FILE_PATH"]
      end

      def squash_config_options
        options = {
          :api_host => squash_host,
          :api_key => squash_api_key,
          :environment => Smith.environment.to_s,
          :skip_ssl_verification => skip_ssl_verification?
        }
        options.merge!(:revision_file => revision_file_path) if revision_file_path
        options
      end
    end
  end
end
