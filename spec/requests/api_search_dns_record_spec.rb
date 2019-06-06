require 'rails_helper'

describe 'Api search dns entry' do
  before :each do
    @record = create(:record)
    @host = create(:host)
    @record.hosts << @host

    @record_excluded = create(:record)
    @host_excluded = create(:host)
    @record_excluded.hosts << @host_excluded
  end

  it 'Successfully create an entry only using page' do
    post '/api/v1/records/search', params: { page: 1 }

    expect(response).to have_http_status(:ok)
  end

  it 'Search included results' do
    post '/api/v1/records/search', params: { page: 1,
                                             included: [@host.url]
                                           }
    resp = JSON.parse(response.body)

    expect(resp['total']).to eq(1)
    expect(resp['matches']).to eq(@record.ip)
    expect(resp['matches_hosts']).to include(@host.url)
  end

  it 'Search excluding results' do
    post '/api/v1/records/search', params: { page: 1,
                                             excluded: [@host_excluded.url]
                                           }
    resp = JSON.parse(response.body)

    expect(resp['matches_hosts'].count).to eq(1)
    expect(resp['matches_hosts']).to include(@host.url)
    expect(resp['matches_hosts']).to_not include(@host_excluded.url)
    expect(resp['matches_hosts']).to_not include(@host_excluded.url)
  end

  it 'Search by record and record_excluded results' do
    post '/api/v1/records/search', params: { page: 1,
                                             included: [@host.url],
                                             excluded: [@host_excluded.url]
                                           }
    resp = JSON.parse(response.body)

    expect(resp['total']).to eq(1)
    expect(resp['matches']).to eq(@record.ip)
    expect(resp['matches_hosts']).to eq(@host.url)
    expect(resp['matches']).to_not eq(@record_excluded.ip)
    expect(resp['matches_hosts']).to_not eq(@host_excluded.url)
  end
end
