# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    # association :task, factory: :task
    # association :user, factory: :user
    # FactoryBot is capable of automatically generating associations for entities.
    # So if we generate an instance of comment, an instance of user and task will be auto-generated,
    # given their factories are defined.
    user
    task
    content { Faker::Lorem.sentence[0..511] }
  end
end
