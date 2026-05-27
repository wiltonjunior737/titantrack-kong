TitanTrack AI

Este repositório contém a implementação da esteira de CI/CD, containerização e observabilidade do microsserviço BFF Service.



REPOSITÓRIO

* Repositório: https://github.com/GuilhermeWoloszyn/titantrack



\---



1. Link dos ambientes



O deploy automático foi configurado utilizando o Render baseado na estratégia de Git Flow:



* Ambiente de DEV (Branch "develop"): https://titantrack-wgv3.onrender.com

&#x20;   - Nota: Swagger habilitado em "/docs".

* Ambiente de HOMOL (Branch "master"): https://titantrack-bfff-homol.onrender.com/

&#x20;   - Nota: Swagger desabilitado em homologação para conformidade de segurança (Retorna 404).



\---



2\. Pipeline de CI/CD (GitHub Actions e SonarCloud)



O pipeline automatizado executa as seguintes etapas a cada push ou pull request nas branches principais:

1\.  Build e setup: Inicialização do ambiente isolado com Python 3.10.

2\.  Instalação de dependências: Configuração do ecossistema do BFF.

3\.  Testes automatizados: Execução do "pytest" com validação de cobertura via "pytest-cov".

4\.  Trava de segurança: O pipeline falha automaticamente caso a cobertura de código seja inferior a 50% (em 62% conforme os testes).

5\.  Análise de qualidade: Integração oficial com o SonarCloud para auditoria de bugs e vulnerabilidades.



\---



3\. Segurança e Versionamento



* Segurança (Dependabot): Ativado e configurado pelo ".github/dependabot.yml" para varredura diária de vulnerabilidades em dependências do Python.
* Versionamento Semântico: Utilização de tags Git para controle de releases (Versão 1.0.0).



Monitoramento Real

Caminho: devops/monitoring/dashboard\_metricas.png / devops/monitoring/dashboard\_numeros.png



\---



4\. Observabilidade



O microsserviço expõe métricas nativas do ecossistema FastAPI na rota "/metrics". 

* Prometheus: Configurado para realizar o "scrape" dos dados diretamente do servidor de nuvem a cada 5 segundos.
* Grafana: Dashboards locais conectados à base do Prometheus demonstrando volumetria de requisições HTTP, consumo de memória e tempo de resposta.

