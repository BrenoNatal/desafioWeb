class ServicesController < ApplicationController
  # Cria o serviço da visita do gerente
  def create
    @service = Service.new(service_params)

    if @service.save
      account = Account.find_by(id: @service.account_id)

      account.balance = account.balance - @service.amount

      account.save

      redirect_to statement_statement_path, notice: "Visita agendada com sucesso."
    else
      redirect_to statement_statement_path, notice: "Erro ao agendar visita."
    end
  end

  private

  def service_params
    params.require(:service).permit(:service_type, :account_id, :amount)
  end
end
