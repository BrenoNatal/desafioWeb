class DepositsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_deposit, only: %i[ show edit update destroy ]

  # GET /deposits or /deposits.json
  def index
    @deposits = Deposit.all
  end

  # GET /deposits/1 or /deposits/1.json
  def show
  end

  # GET /deposits/new
  def new
    @deposit = Deposit.new
  end

  # GET /deposits/1/edit
  def edit
  end

  # POST /deposits or /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)

    respond_to do |format|
      if @deposit.save

        # Busca a conta envolvida
        account = Account.where(id: @deposit.account_id)[0]

        # Atualiza o saldo das conta
        account.balance = account.balance + @deposit.amount

        # Salva as mudanças
        account.save

        format.html { redirect_to @deposit, notice: "Deposito feito com sucesso." }
        format.json { render :show, status: :created, location: @deposit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deposits/1 or /deposits/1.json
  def update
    respond_to do |format|
      if @deposit.update(deposit_params)
        format.html { redirect_to @deposit, notice: "Deposit was successfully updated." }
        format.json { render :show, status: :ok, location: @deposit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deposits/1 or /deposits/1.json
  def destroy
    @deposit.destroy!

    respond_to do |format|
      format.html { redirect_to deposits_path, status: :see_other, notice: "Deposit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = Deposit.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def deposit_params
      params.expect(deposit: [ :amount, :account_id ])
    end
end
