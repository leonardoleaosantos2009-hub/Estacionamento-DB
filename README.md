# 🚗 Estacionamento DB — Sistema de Gestão de Estacionamento em MySQL

Este projeto consiste em um sistema de banco de dados relacional desenvolvido em **MySQL** para gerenciamento de fluxo de veículos e proprietários em um estacionamento. 

O sistema conta com tabelas relacionais, **Stored Procedures** para automação de cadastros/atualizações e uma **Stored Function** para o cálculo automático da taxa de permanência com base no tempo de uso.

---

## 📐 Estrutura do Banco de Dados

O modelo de dados é composto por duas tabelas principais relacionadas entre si:

1. **`proprietarios`**: Armazena as informações dos clientes do estacionamento.
2. **`veiculos`**: Armazena os dados dos veículos cadastrados e vinculados a um proprietário, além dos horários de entrada/saída e valores pagos.

```
 [proprietarios] 1 ─── N [veiculos]
```

### Dicionário de Dados

#### Tabela `proprietarios`
| Coluna | Tipo | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | `INT` | PRIMARY KEY, AUTO_INCREMENT | Identificador único do proprietário |
| `nome` | `VARCHAR(100)` | NOT NULL | Nome completo |
| `cpf` | `VARCHAR(15)` | NOT NULL, UNIQUE | CPF do proprietário |
| `telefone` | `VARCHAR(20)` | NOT NULL | Telefone de contato |

#### Tabela `veiculos`
| Coluna | Tipo | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | `INT` | PRIMARY KEY, AUTO_INCREMENT | Identificador único do veículo |
| `id_proprietario` | `INT` | NOT NULL, FOREIGN KEY | Chave estrangeira para `proprietarios(id)` |
| `placa` | `VARCHAR(10)` | NOT NULL, UNIQUE | Placa do veículo |
| `modelo` | `VARCHAR(50)` | NOT NULL | Modelo do veículo |
| `cor` | `VARCHAR(25)` | NOT NULL | Cor do veículo |
| `data_entrada` | `DATETIME` | NOT NULL | Data e hora de entrada no estacionamento |
| `data_saida` | `DATETIME` | NULL | Data e hora de saída do estacionamento |
| `valor_pago` | `DECIMAL(10,2)`| NULL | Valor total cobrado pelo período |

---

## ⚙️ Regras de Negócio e Precificação

A tarifação é calculada automaticamente através de uma **Stored Function**:
* **Valor Base:** R$ 8,00 por hora (ou fração de hora).
* **Cálculo da Duração:** É utilizada a função `TIMESTAMPDIFF(MINUTE, ...)` dividida por 60 e arredondada para cima via `CEIL()`.
* **Fórmula de Cobrança:**
  $$\text{Valor Total} = \left\lceil \frac{\Delta t_{\text{minutos}}}{60} \right\rceil \times 8{,}00$$

---

## 🛠️ Rotinas Armazenadas (Procedures & Functions)

### 1. Inserção / Cadastro
* **`cadastrar_proprietario(p_nome, p_cpf, p_telefone)`**: Insere um novo cliente.
* **`cadastrar_veiculo(p_id_proprietario, p_placa, p_modelo, p_cor, p_data_entrada)`**: Registra a entrada de um novo veículo no pátio.

### 2. Atualização de Dados
* **`atualizar_proprietario(p_id, p_telefone)`**: Atualiza o telefone do proprietário.
* **`atualizar_veiculo(p_id, p_placa)`**: Corrige ou atualiza a placa de um veículo.

### 3. Funções de Cálculo e Registro de Saída
* **`calcular_valor(p_data_entrada, p_data_saida)`**: Retorna o valor calculado com base na diferença de tempo entre a entrada e a saída.
* **`atualizar_veiculo_saida(p_id, p_data_saida, p_valor_pago)`**: Registra a saída do veículo e atualiza o valor cobrado chamando internamente a função `calcular_valor()`.

---

## 🚀 Ordem de Execução dos Scripts

Para configurar o ambiente do zero, execute os arquivos SQL na seguinte sequência:

1. **`criação Veículo.sql`**: Apaga/cria a base de dados `estacionamento_db` e define a estrutura de tabelas.
2. **`Cadastro de Proprietário e de Veículo.sql`**: Cria as procedures de cadastro e insere os registros iniciais.
3. **`Cálculo do Valor Cobrado - veiculo.sql`**: Cria a função `calcular_valor`.
4. **`Atualização de Proprietário e de Veículo.sql`**: Cria procedures auxiliares para manutenção de cadastros.
5. **`Registro de Saída de Veículo.sql`**: Cria a procedure de saída de veículos com integração do cálculo automático.

---

## 🧪 Exemplos de Uso

### Cadastrar Proprietário e Veículo
```sql
-- Cadastrar um proprietário
CALL cadastrar_proprietario('Roberto Almeida', '123.456.789-01', '(14) 99811-2233');

-- Registrar entrada do veículo
CALL cadastrar_veiculo(1, 'ABC1D23', 'Fiat Argo', 'Prata', '2026-10-29 07:45:00');
```

### Registrar Saída do Veículo
```sql
-- Registrar saída do veículo (ID = 1) no dia 2026-10-29 às 09:00:00
CALL atualizar_veiculo_saida(1, '2026-10-29 09:00:00', 16.00);
```

### Consultar veículos no pátio
```sql
SELECT 
    v.id,
    v.placa,
    v.modelo,
    p.nome AS proprietario,
    v.data_entrada,
    v.data_saida,
    v.valor_pago
FROM veiculos v
JOIN proprietarios p ON v.id_proprietario = p.id;
```
