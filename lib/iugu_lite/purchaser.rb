require_relative '../iugu_lite'

class IuguLite::Purchaser
  def initialize(**args)
    args.each do |field, value|
      instance_variable_set("@#{field}", value)
      self.class.define_method(field) do
        instance_variable_get("@#{field}")
      end
    end
  end

  class << self
    def create(**args)
      response = IuguLite.client.post('purchasers') do |req|
        req.body = args.to_json
      end
      new(**response.body)
    end
  end
end
