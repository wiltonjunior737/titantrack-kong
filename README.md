Este submódulo estabelece a camada de controle de tráfego e observabilidade centralizada do ecossistema fitness, operando o roteamento das requisições para os microsserviços e a coleta de dados de performance.

A arquitetura do gateway foi projetada para unificar o ponto de entrada da aplicação tanto no ambiente de desenvolvimento local quanto nos servidores de homologação em nuvem. O componente principal é o Kong API Gateway, que recebe todas as requisições externas na porta oitocentos e gerencia os redirecionamentos internos baseando-se nos caminhos declarados pelas rotas. Integrado a ele, o sistema de monitoramento utiliza o Prometheus para coletar métricas de saúde da aplicação e o Grafana para gerar as séries temporais analíticas do tráfego.

A estrutura de isolamento e entrega contínua do gateway foi configurada no Render seguindo rigorosamente a divisão por ambientes e ramificações de código do projeto. O ambiente titantrack-kong-dev monitora ativamente a branch develop do repositório, mantendo o Swagger e os endpoints de teste totalmente liberados para a equipe. O ambiente titantrack-kong-homol monitora a branch master principal, aplicando as restrições de segurança de produção, o que inclui a desativação da rota de documentação api-docs para bloquear acessos externos não autorizados.

Para a inicialização do ecossistema de desenvolvimento integrado na máquina local, o Docker Compose é utilizado para erguer o gateway, os microsserviços bff-service, auth-service, workout-service e nutrition-service, além dos bancos de dados PostgreSQL e MongoDB. O comando de execução deve ser rodado a partir do diretório raiz.

docker compose up -d

A validação do roteamento do Kong em ambiente de desenvolvimento é realizada acessando a URL local mapeada com o prefixo configurado para o microsserviço principal.

http://localhost:8000/api/docs

Para a camada de observabilidade, o arquivo de configuração do Prometheus local, nomeado como prometheus.yml, foi estruturado para buscar as métricas geradas na nuvem de homologação a cada quinze segundos através do endpoint seguro de telemetria.

global:
scrape_interval: 15s

scrape_configs:

job_name: 'fastapi-homologacao'
metrics_path: '/metrics'
scheme: 'https'
static_configs:

targets: ['titantrack-bfff-homol.onrender.com']

A conexão de rede no painel do Grafana local em http://localhost:3000 utiliza a URL interna de comunicação do Docker Desktop para alcançar os dados coletados no host do Windows.

http://host.docker.internal:9090

O resultado prático da integração de monitoramento gerou os painéis analíticos que processam o volume de tráfego por métodos HTTP e códigos de status, cujos registros visuais estão salvos neste diretório de documentação sob os nomes de arquivo dashboard-metricas.png e dashboard-numeros.png.