

url = 'https://data.cityofnewyork.us/resource/9n6h-pt9g.json' #dados redutores de velocidade
url2 = 'https://data.cityofnewyork.us/resource/h9gi-nx95.json' #dados de colisão de veiculos




from datetime import datetime

from airflow import DAG
from airflow.decorators import task, dag
from airflow.operators.bash import PythonOperator

from datetime import datetime
from time import sleep

SRC = "https://"

##########################################################

@dag(start_date=now, schedule="@daily", catchup=False)
def etl():
    @task():
    def retrieve(src:Dataset) -> dict:
        resp = requests.get(url=src.uri)
        data = resp.json()
        return data["data"]

        hook = WasbHook(wasb_conn_id="azure_blob_storage")
        hook.load_file(tmp_path, container_name=CONTAINER_LANDING_ZONE, blob_name=file_name)

data = retrieve(SRC)


etl()
############################################################


default_args={
    "depends_on_past": False,
    "email": ["crisosilva88@gmail.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
    # 'queue': 'bash_queue',
    # 'pool': 'backfill',
    # 'priority_weight': 10,
    # 'end_date': datetime(2016, 1, 1),
    # 'wait_for_downstream': False,
    # 'sla': timedelta(hours=2),
    # 'execution_timeout': timedelta(seconds=300),
    # 'on_failure_callback': some_function,
    # 'on_success_callback': some_other_function,
    # 'on_retry_callback': another_function,
    # 'sla_miss_callback': yet_another_function,
    # 'trigger_rule': 'all_success'
}


# A DAG represents a workflow, a collection of tasks
with DAG(
    dag_id="ny_collisions",
    default_args=default_args,
    description="ny collisons study and speed reducers installation evaluation", 
    start_date=datetime(2022, 12, 17), 
    schedule=timedelta(days=1),
    catchup=False,
    tags=["collisons", "crash", "ny", "car", "speed_reducers"]
) as dag:



# Tasks are represented as operators
    hello = BashOperator(task_id="hello", bash_command="echo hello")

    @task()
    def airflow():
        print("airflow")

    # Set dependencies between tasks
    hello >> airflow()
