class ContaBancaria {
  var titular: String = ""
  var saldo: Double

  init(titular: String, saldo: Double) {
      self.titular = titular
      self.saldo = saldo
  }

  func sacar() {
      print(" ----- SAQUE ----- ")
      print("Valor do saque: ", terminator: "")
      let valor = Double(readLine() ?? "") ?? 0.00
      print(" ----- ----- ----- \n")
      if(valor <= saldo) {
          saldo -= valor
          print("Saque de R$ \(valor) realizado com sucesso.\n")
          
      } else {
          print("Saldo insuficiente ... \n")
      }
  }

  func extrato() {
      print("\n--- Extrato ---")
      print("Titular: \(titular)")
      print("Saldo: R$ \(saldo)")
      print("--- --- --- ---\n")
  }
}

func menu() -> Int {
  print("--- Bem vindo ao Banco Eduvi Doutores LTDA ---")
  print("""
  \nEscolha uma opção:
  1. Criar Conta.
  2. Sacar.
  3. Ver saldo.
  4. Sair\n
  """)

  print("O que deseja? ", terminator: "")
  return Int(readLine() ?? "") ?? 0
}

func IniciarBanco() {
  var cliente: ContaBancaria? = nil

  while true {
      let opcao = menu()

      switch opcao {
            case 1:
                cliente = CriarConta()
                print("Conta criada com sucesso!\n")
            case 2:
                if let cliente = cliente {
                    cliente.sacar()
                } else {
                    print("Conta não encontrada! Por favor, crie uma conta.\n")
                }
            case 3:
                if let cliente = cliente {
                    cliente.extrato()
                } else {
                    print("Conta não encontrada! Por favor, crie uma conta.\n")
                }
            case 4:
                print("Obrigado por nos visitar!\nASS: Banco Eduvi Doutores LTDA ...")
                return
            default:
                print("Opção inválida! Tente novamente.")
            
      }
  }

}

func CriarConta() -> ContaBancaria{
    print("Digite seu nome: ", terminator:"")
    let titular = readLine() ?? ""
    let saldo = 1000.00
    print("Saldo inicial de R$ 1000.00")

    return ContaBancaria(titular: titular, saldo: saldo)
}

IniciarBanco()