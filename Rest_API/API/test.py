import sys
import findspark
findspark.init()
findspark.find()
import pyspark
print(findspark.find())

from pyspark import SparkContext, SQLContext
from pyspark.sql import SparkSession
# from pyspark.sql.types import StructType,StructField, StringType, IntegerType,BooleanType,DoubleType

# spark = SparkSession.builder \
# .appName('Spark_test') \
# .master('local[*]') \
# .config('spark.sql.execution.arrow.pyspark.enabled', True) \
# .config('spark.sql.session.timeZone', 'UTC') \
# .config('spark.driver.memory','32G') \
# .config('spark.ui.showConsoleProgress', True) \
# .config('spark.sql.repl.eagerEval.enabled', True) \
# .getOrCreate()

# conf = pyspark.SparkConf().setAppName("").set("spark.ui.port", "25333")

#      .enableHiveSupport() \
#      .config("spark.some.config.option", "some-value") \

spark = SparkSession.builder.master("local").appName("Spark_test").config("spark.some.config.option", "some-value").getOrCreate()
