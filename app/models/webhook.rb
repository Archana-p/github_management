class Webhook < ActiveRecord::Base
  belongs_to :repo
end
