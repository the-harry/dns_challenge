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

  def search; end

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
end
