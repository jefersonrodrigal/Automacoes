param (
    [string]$SolutionName
)

# Se não informar o nome, pede via terminal
if ([string]::IsNullOrWhiteSpace($SolutionName)) {
    $SolutionName = Read-Host "Digite o nome do projeto/solução"
}

Write-Host "Criando solução '$SolutionName'..." -ForegroundColor Green

# Criar solução
dotnet new sln -n $SolutionName

# Criar projetos
dotnet new classlib -n "$SolutionName.Domain"
dotnet new classlib -n "$SolutionName.Application"
dotnet new classlib -n "$SolutionName.Infrastructure"
dotnet new webapi   -n "$SolutionName.API"

# Adicionar projetos à solução
dotnet sln add "$SolutionName.Domain"
dotnet sln add "$SolutionName.Application"
dotnet sln add "$SolutionName.Infrastructure"
dotnet sln add "$SolutionName.API"

# Adicionar referências (ordem correta)
dotnet add "$SolutionName.Application" reference "$SolutionName.Domain"

dotnet add "$SolutionName.Infrastructure" reference "$SolutionName.Application"
dotnet add "$SolutionName.Infrastructure" reference "$SolutionName.Domain"

dotnet add "$SolutionName.API" reference "$SolutionName.Application"
dotnet add "$SolutionName.API" reference "$SolutionName.Infrastructure"

Write-Host "Estrutura Clean Architecture criada com sucesso!" -ForegroundColor Cyan
