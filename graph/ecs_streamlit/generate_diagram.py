from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import ECS, Fargate, ECR
from diagrams.aws.network import ALB, VPC, PublicSubnet
from diagrams.aws.management import ParameterStore, CloudwatchLogs
from diagrams.aws.ml import Bedrock
from diagrams.aws.database import Dynamodb
from diagrams.onprem.client import User

with Diagram("ECS Streamlit Architecture", show=False, filename="ecs_streamlit_diagram", direction="TB"):
    user = User("User")

    with Cluster("AWS Cloud"):
        with Cluster("VPC: dev-vpc-streamlit-tf"):
            with Cluster("Public Subnets"):
                alb = ALB("ALB: dev-ecs-streamlit-tf")
                
                with Cluster("ECS Cluster: dev-streamlit-tf"):
                    with Cluster("ECS Service"):
                        with Cluster("ECS Task"):
                            streamlit = Fargate("Streamlit Container\n(Port 8501)")

        with Cluster("Management & Storage"):
            ecr = ECR("ECR: dev-streamlit-tf")
            ssm = ParameterStore("SSM Parameters")
            cwl = CloudwatchLogs("CloudWatch Logs")

        with Cluster("AI & External Services"):
            bedrock = Bedrock("Amazon Bedrock")
            pinecone = Dynamodb("Pinecone API\n(External)")

    # Connections
    user >> Edge(label="HTTP:80") >> alb
    alb >> Edge(label="HTTP:8501") >> streamlit
    
    streamlit >> Edge(style="dotted", label="Pull") >> ecr
    streamlit >> Edge(style="dotted", label="Get") >> ssm
    streamlit >> Edge(style="dotted", label="Log") >> cwl
    
    streamlit >> Edge(color="blue", label="Invoke") >> bedrock
    streamlit >> Edge(color="blue", label="Query") >> pinecone
