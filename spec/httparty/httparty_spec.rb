describe 'HTTParty' do
  # Sem VCR Metadata
  # it 'content-type' do
  #   response = HTTParty.get('https://jsonplaceholder.typicode.com/users')
  #   content_type = response.headers['content-type']
  #
  #   expect(content_type).to match(/application\/json/)
  # end
  #
  # it 'Stub Request' do
  #   stub_request(:get, "https://jsonplaceholder.typicode.com/users").
  #     to_return(status: 200, body: "", headers: { 'content-type': 'application/json' })
  #
  #   response = HTTParty.get('https://jsonplaceholder.typicode.com/users')
  #   content_type = response.headers['content-type']
  #
  #   expect(content_type).to match(/application\/json/)
  # end
  #
  # it 'vcr cassettes' do
  #   VCR.use_cassette('jsonplaceholder/users') do
  #     response = HTTParty.get('https://jsonplaceholder.typicode.com/users')
  #     content_type = response.headers['content-type']
  #
  #     expect(content_type).to match(/application\/json/)
  #   end
  # end

  # Com VCR Metadata
  # it 'vcr cassettes metadata', vcr: { cassette_name: 'jsonplaceholder/users', match_requests_on: [:body] } do
  #   response = HTTParty.get('https://jsonplaceholder.typicode.com/users')
  #   content_type = response.headers['content-type']
  #
  #   expect(content_type).to match(/application\/json/)
  # end

  it 'vcr cassettes metadata', vcr: { cassette_name: 'jsonplaceholder/users', :record => :new_episodes } do
    response = HTTParty.get('https://jsonplaceholder.typicode.com/users')
    content_type = response.headers['content-type']

    expect(content_type).to match(/application\/json/)
  end
end