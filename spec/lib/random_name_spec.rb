require 'rspec'
require 'webmock/rspec'

require_relative '../../lib/random_name'

RSpec.describe 'Random Name generator' do
  before do
    stub_request(:get, 'https://randomuser.me/api/')
      .to_return(
        status: 200,
        body: {
          'results' => [
            'name' => {
              'first' => 'Rand',
              'last' => "Al'thor"
            }
          ]
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
    )
  end

  it "returns a first name" do

    puts get_first_name
    expect(get_first_name).to eq('Rand')
  end

  it 'returns a last name' do
    name = get_last_name
    expect(name).to eq("Al'thor")
  end

  it 'returns a full name' do
    name = get_full_name
    expect(name).to eq("Rand Al'thor")
  end

  it 'handles an unsuccessful api call' do
    stub_request(:get, 'https://randomuser.me/api/')
      .to_return(
        status: 500,
        body: {
          'results' => [
            'name' => {
              'first' => "nil",
              'last' => "nil"
            }
          ]
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
    )
    name = get_full_name
    expect(name).to eq "al'Lan Mandragoran"
  end
end
