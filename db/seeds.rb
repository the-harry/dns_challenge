record = FactoryBot.create(:record, ip: '1.1.1.1')
host = FactoryBot.create(:host, url: 'lorem.com')
record.hosts << host
