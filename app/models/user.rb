# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :postal_code, format: { with: /\A\d{7}\z/ }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
