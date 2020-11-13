FROM mrsipan/py-spark

ENV PATH="/usr/pgsql-13/bin:/opt/clean_python/3.7.9/bin:${PATH}"
ENV PYSPARK_PYTHON=/opt/clean_python/3.7.9/bin/python3.7 

WORKDIR /build

RUN yum -y install postgresql-devel gcc centos-release-scl
RUN yum -y install rh-nodejs12


RUN yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN yum install -y postgresql13-server


RUN alternatives --install \
      /usr/bin/node node /opt/rh/rh-nodejs12/root/usr/bin/node 1 \
      --slave /usr/bin/npm npm /opt/rh/rh-nodejs12/root/usr/bin/npm

RUN pip3 install --upgrade pip && \
    pip3 install cython \
                 RelStorage==2.1.1 \
                 bobo \
                 cffi \
                 httpie \
                 jupyterlab \
                 keras \
                 matplotlib \
                 newt.db \
                 ninja \
                 pandas \
                 pgcli \
                 pyspark \
                 pyvim \
                 requests \
                 scikit-learn \
                 seaborn \
                 tensorflow \
                 xonsh

RUN pip3 install torch==1.7.0+cpu \
                 torchvision==0.8.1+cpu \
                 torchaudio==0.7.0 \
                 -f https://download.pytorch.org/whl/torch_stable.html

RUN jupyter labextension install @axlair/jupyterlab_vim

EXPOSE 8888

CMD ["jupyter", "lab", "--allow-root", "--ip=0.0.0.0"]
