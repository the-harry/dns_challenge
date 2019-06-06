require 'rails_helper'

describe 'Api create dns record' do
  let(:ip) { '192.268.0.1' }
  let(:host) { ['testsite.com.br'] }
  let(:hosts) { ['site3.com.br', 'site6.com.br', 'site9.com.br'] }

  context 'Successfully create record with one host' do
    it 'Successfully create an entry with one host' do
      post '/api/v1/records', params: { ip: ip, hosts: host }

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:created)
    end

    it 'Returns record id' do
      post '/api/v1/records', params: { ip: ip, hosts: host }
      resp = JSON.parse(response.body)

      expect(resp['record_id']).to_not eq(nil)
    end
  end

  context 'Successfully create record with multiple hosts' do
    it 'Successfully create an entry with hosts' do
      post '/api/v1/records', params: { ip: ip, hosts: hosts }

      expect(response).to have_http_status(:created)
    end

    it 'Returns record id' do
      post '/api/v1/records', params: { ip: ip, hosts: hosts }
      resp = JSON.parse(response.body)

      expect(resp['record_id']).to_not eq(nil)
    end
  end

  context 'Api cant create dns entry' do
    it 'Dont have ip' do
      post '/api/v1/records', params: { hosts: host }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'Dont have host' do
      post '/api/v1/records', params: { ip: ip }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
