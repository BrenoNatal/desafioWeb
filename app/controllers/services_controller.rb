class ServicesController < ApplicationController
  def create
    @service = Service.new(service_params)

    if @service.save
      account = Account.find_by(id: @service.account_id)

      account.balance = account.balance - @service.amount

      account.save

      redirect_to services_path, notice: "Service criada com sucesso."
    else
      redirect_to services_path, alert: "Erro ao criar a service."
    end
  end

  private

  def service_params
    params.require(:service).permit(:service_type, :account_id, :amount)
  end
end
