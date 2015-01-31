require 'squash/ruby'

module SquashableAgent
  def use_squash?
    squash_host && squash_api_key
  end

  def squash_host
    ENV["SQUASH_HOST"]
  end

  def squash_api_key
    ENV["SQUASH_API_KEY"]
  end

  def enable_squash
    if use_squash?
      Squash::Ruby.configure(
        :api_host => squash_host,
        :api_key => squash_api_key,
        :environment => Smith.environment.to_s,
        :revision_file => Pathname.new("~/app/current/REVISION").expand_path.to_s,
        :skip_ssl_verification => true
      )

      on_exception do |exception|
        Squash::Ruby.notify(exception)
      end
    end
  end
end
