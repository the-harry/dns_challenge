class Api::V1::RecordsController < ::ApplicationController
  def create
    record = Record.new(ip: record_params[:ip])
    generate_host(record) unless host_params[:hosts].nil?
    if !record.hosts.last.nil? && record.save
      render json: { record_id: record.id }, status: :created
    else
      render json: { error: 'Sorry, try again.' }, status: :unauthorized
    end
  end

  def search
    page = search_params[:page]
    included = search_params[:included]
    excluded = search_params[:excluded]
    records = query_selector(page, included, excluded)
    if records.any?
      render json: search_response(records), status: :ok
    else
      render json: { error: 'No results found.' }, status: :not_found
    end
  end

  private

  def record_params
    params.permit(:ip)
  end

  def host_params
    params.permit(hosts: [])
  end

  def generate_host(record)
    host_params[:hosts].each do |host|
      record.hosts.new(url: host)
    end
  end

  def search_params
    params.permit(:page, included: [], excluded: [])
  end

  def query_selector(page, included, excluded)
    records = []

    if included.nil? && excluded.nil?
      records = Host.all
    elsif !included.nil? && excluded.nil?
      included.each do |i|
        records << Host.find_by(url: i)
      end
    elsif included.nil? && !excluded.nil?
      excluded.each do |e|
        records << Host.where.not(url: e)
      end
    else
      record = []
      excluded.each do |e|
        record << Host.where.not(url: e)
      end
      record.each_with_index do |r, index|
        records << r if included[index].include?(r[index].url)
      end
    end

    Kaminari.paginate_array(records).page(page)
  end

  def search_response(records)
    matches = []
    matches_hosts = []

    records.each_with_index do |host, h_index|
      matches_hosts << if host.instance_of? Host
                         { host: host.url, total: host.records.count }
                       else
                         { host: host[h_index].url, total: host.records.count }
                       end
      host.records.each_with_index do |record, r_index|
        matches << if record.instance_of? Record
                     { id: record.id, ip: record.ip }
                   else
                     { id: record.id, ip: record.records[r_index].ip }
                   end
      end
    end

    total = matches.count

    { total: total, matches: matches, matches_hosts: matches_hosts }.to_json
  end
end
