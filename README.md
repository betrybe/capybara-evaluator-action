# Capybara Evaluator Action for Tryber projects

Aplicação para teste e correção dos projetos dos estudantes da Trybe utilizando Capybara.

Esta aplicação vai executar os testes a partir do nome do repositório dos estudantes, que deve ser obtido via ENV VAR.

## Guia de instalação do ambiente de desenvolvimento

Para instalar e executar esta aplicação em ambiente de desenvolvimento, siga este [guia](/INSTALLATION.md).

## Inputs

## Outputs

### `evaluation`

Arquivo JSON em formato base64 com a saída avaliada pelo RSpec.

### `result`

Arquivo JSON em formato base64 com o resultado, em notas por requisito, dos testes executados.

## Exemplo de uso
```yml
uses: betrybe/capybara-evaluator-action
```

## Como obter o valor da output do resultado
```yml
- name: Capybara evaluator
  id: evaluator
  uses: betrybe/capybara-evaluator-action
- name: Next step
  uses: another-github-action
  with:
    param: ${{ steps.evaluator.outputs.result }}
```

## Restrições do projeto

O projeto que precisar utilizar essa action deve possuir um arquivo com o nome `requirements_mapping.json` em seu diretório raiz. Esse arquivo deve conter a seguinte estrutura:

```json
{
  "test-name-1": 17,
  "unit test 2 name": 36,
}
```

Onde `"test-name-1"` e `"unit test 2 name"` são os nomes/descrições dos testes e, `17` e `36` são os identificadores (IDs) desses requisitos.

## Aprenda sobre GitHub Actions

- https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-a-docker-container-action
