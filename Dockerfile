FROM python:3.13.4-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
# Isso evita que os arquivos do projeto se espalhem pelo sistema de arquivos do contêiner.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências
# Copiamos este arquivo primeiro para aproveitar o cache de camadas do Docker.
# A instalação das dependências só será executada novamente se o requirements.txt mudar.
COPY requirements.txt .

# Etapa 4: Instalar as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação
COPY . .

# Etapa 6: Comando para iniciar a aplicação quando o contêiner for executado
# Usamos --host 0.0.0.0 para que a API seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
