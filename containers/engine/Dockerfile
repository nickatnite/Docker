FROM xxxxxxxxxx/miniconda2-base:0.0.2

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8


# Update Ubuntu, install dependencies, and configure celery user.
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y povray \
        gcc \
        python-cffi \
        libcairo2 \
        libpango1.0-0 \
        libgdk-pixbuf2.0-0 \
        libffi-dev \
        shared-mime-info \
        language-pack-en-base && \
    dpkg-reconfigure locales && \
    useradd celery -m -s /bin/bash


# Install engine and ERP dependencies.
RUN pip install celery[redis] \
        timeout-decorator \
        holidays \
        flask_cdn \
        flask_bcrypt \
        flask_wtf \
        flask_weasyprint \
        flask_cache \
        flask_login \
        eve \
        pymongo==2.9.1 \
        mongoengine==0.10.5 \
        pycountry \
        slugify \
        shippo \
        pyqrcode \
        passwordmeter \
        python-json-logger \
        https://xxxxxxxxxx-xxxxxxxxxx-pkg.s3-accelerate.amazonaws.com/wheel/Eve_Mongoengine-0.0.10-py2-none-any.whl \
        https://xxxxxxxxxx-xxxxxxxxxx-pkg.s3-accelerate.amazonaws.com/wheel/xxxxxxxxxx_API-3.2.2-py2-none-any.whl \
        https://xxxxxxxxxx-xxxxxxxxxx-pkg.s3-accelerate.amazonaws.com/wheel/pricing-3.2.2-py2-none-any.whl && \
    conda install -yq numpy==1.11.2 \
        scipy==0.17.0 \
        scikit-learn==0.18.1 \
        cython \
        pandas \
        boto \
        matplotlib \
        pillow \
        click \
        memory_profiler \
        pytest \
        pytest-cov \
        gitpython \
        jinja2 \
        line_profiler \
        six \
        pyparsing==2.1.4 \
        xxxxxxxxxx_models==1.3.4 \
        python-logstash \
        cad_wrapper \
        psutil \
        vapory \
        boto3 \
        pycurl \
        werkzeug \
        flask \
        ujson \
        simplejson && \
    conda clean -ya

# Set pythonpath
ENV PYTHONPATH=/opt


# Install application code into container.
COPY xxxxxxxxxx_engine /opt/xxxxxxxxxx_engine
COPY xxxxxxxxxx_erp /opt/xxxxxxxxxx_erp
COPY xxxxxxxxxx_geod /opt/xxxxxxxxxx_geod

RUN ln -s /opt/xxxxxxxxxx_engine /opt/nextline_engine
RUN ln -s /opt/xxxxxxxxxx_erp /opt/nextline_erp
RUN ln -s /opt/xxxxxxxxxx_geod /opt/nextline_geod

# Set runtime environment.
ENTRYPOINT ["/bin/bash", "-c"]
