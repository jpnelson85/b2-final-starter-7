require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'method retrieve_holidays returns an array of hashes' do
    expect(retrieve_holidays).to be_a(Array)
    expect(retrieve_holidays[0]).to be_a(Hash)
  end
end
