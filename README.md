# Aplicação Ruby on Rails

Este é um projeto Ruby on Rails feito para antender os requisitos de um desafio.

## Requisitos da Aplicação

### Identificação/Login do Correntista

#### Entradas:
- **Conta corrente**: 5 dígitos.
- **Senha**: 4 dígitos.

### Opções Disponíveis:

1. **Ver Saldo**  
   - Exibe apenas o valor atualizado em R$.

2. **Extrato**  
   - Exibe:
     - Data.
     - Hora.
     - Descrição.
     - Valor (valores negativos entre parênteses).

3. **Saque**  
   - **Usuário Normal**:
     - Não pode sacar além do valor disponível em saldo.  
   - **Usuário VIP**:
     - Pode sacar além do saldo disponível.
     - Saldo negativo será reduzido em **0,1% por minuto** até que depósitos suficientes sejam feitos para cobrir o saldo negativo.

4. **Depósito**  
   - Permite realizar depósitos para aumentar o saldo disponível.

5. **Transferência**  
   - Usuário pode transferir valores informando a conta corrente do destinatário (regras aplicáveis):
     - Não é possível transferir para si mesmo ou para contas inexistentes.
     - Aparecerá no extrato tanto do cedente quanto do destinatário.
     - **Usuário Normal**:
       - Limite de transferências: **R$1.000,00**.
       - Custo por transferência: **R$8,00** (debitado e destacado no extrato).  
     - **Usuário VIP**:
       - Sem limite de valor.
       - Custo por transferência: **0,8% do valor transferido** (debitado e destacado no extrato).

6. **Solicitar Visita do Gerente**  
   - Disponível apenas para usuários VIP.
   - Necessária confirmação do usuário.
   - Após confirmação, será debitado **R$50,00** da conta.

7. **Trocar de Usuário**  
   - Permite sair da conta atual e fazer login em outra conta para acessar movimentações de outros correntistas.

## Versões

- Ruby `~> 3.3.6`
- Rails `~> 8.0.1`


# Instalação e Utilização

```bash
   git clone (https://github.com/BrenoNatal/desafioWeb)
   cd desafioWeb
```
- Instalação de dependências
  
```bash
   bundle install
```

- Inicie o Servidor
  
```bash
   rails server
```

# Contas no Site
O projeto ta hospedado em: https://desafioweb.fly.dev


Tem duas contas cadastradas:

  Conta Vip 
  - Numero: 11111
  - Senha: 1234
  
  Conta Normal
  - Numero: 22222
  - Senha: 1234
