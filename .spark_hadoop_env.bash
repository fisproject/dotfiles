export OPENSSL_ROOT_DIR=$(brew --prefix openssl)
export OPENSSL_INCLUDE_DIR=$OPENSSL_ROOT_DIR/include/

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export HADOOP_HOME=/usr/local/hadoop-2.7.3
export HADOOP_PREFIX=$HADOOP_HOME
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_COMMON_LIB_NATIVE_DIR"

export SPARK_DL_DIR=~/tmp/spark-2.3.0-bin-hadoop2.7
ln -s $SPARK_DL_DIR /usr/local/share/spark
export SPARK_HOME=/usr/local/share/spark
export PATH=$PATH:$SPARK_HOME/bin
export PAHT=$PATH:$SPARK_HOME/sbin
