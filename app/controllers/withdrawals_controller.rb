class WithdrawalsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_withdrawal, only: %i[ show edit update destroy ]

  # GET /withdrawals or /withdrawals.json
  def index
    @withdrawals = Withdrawal.all
  end

  # GET /withdrawals/1 or /withdrawals/1.json
  def show
  end

  # GET /withdrawals/new
  def new
    @withdrawal = Withdrawal.new
  end

  # GET /withdrawals/1/edit
  def edit
  end

  # POST /withdrawals or /withdrawals.json
  def create
    @withdrawal = Withdrawal.new(withdrawal_params)

    respond_to do |format|
      if @withdrawal.save

        # Busca a conta envolvida
        account = Account.where(id: @withdrawal.account_id)[0]

        # Atualiza o saldo das conta
        account.balance = account.balance - @withdrawal.amount

        # Salva as mudanças
        account.save

        format.html { redirect_to @withdrawal, notice: "Saque feito com sucesso." }
        format.json { render :show, status: :created, location: @withdrawal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @withdrawal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /withdrawals/1 or /withdrawals/1.json
  def update
    respond_to do |format|
      if @withdrawal.update(withdrawal_params)
        format.html { redirect_to @withdrawal, notice: "Withdrawal was successfully updated." }
        format.json { render :show, status: :ok, location: @withdrawal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @withdrawal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /withdrawals/1 or /withdrawals/1.json
  def destroy
    @withdrawal.destroy!

    respond_to do |format|
      format.html { redirect_to withdrawals_path, status: :see_other, notice: "Withdrawal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_withdrawal
      @withdrawal = Withdrawal.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def withdrawal_params
      params.expect(withdrawal: [ :amount, :account_id ])
    end
end
