data = {
  users: [{ email: 'a@domain.com' }, { email: 'b@domain.com' }]
}

User = Struct.new(:email, keyword_init: true)

module Builders
  class Base
    def initialize(data)
      @data = data
    end

    def build
      raise NotImplementedError, "#{self.class}#build must be implemented"
    end

    def self.to_proc
      proc { |data| new(data).build }
    end
  end
end

class Builders::User < Builders::Base
  def build
    User.new(@data)
  end
end

data[:users].map { |user_data| Builders::User.new(user_data).build }
data[:users].map(&Builders::User)