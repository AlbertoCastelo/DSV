FROM python:3.7.8-slim

RUN apt-get update && \
    apt-get install -y libssl-dev gcc g++ git nano&& \
    pip --no-cache-dir install --upgrade pip

ARG GITHUB_USER
ARG GITHUB_TOKEN
ARG DSV_CONFIGURATION_FILE


RUN echo "${GITHUB_USER}" \
    & echo "${GITHUB_TOKEN}" \
    & echo "${DSV_CONFIGURATION_FILE}"

ENV GITHUB_USER=$GITHUB_USER
ENV GITHUB_TOKEN=$GITHUB_TOKEN
ENV DSV_CONFIGURATION_FILE=$DSV_CONFIGURATION_FILE

# packaging utilities
RUN pip install --user --upgrade setuptools wheel

#COPY ./ /tmp/dsv/
COPY requirements.txt /tmp/dsv/requirements.txt
RUN pip install -r /tmp/dsv/requirements.txt




# RUN mkdir /workspace
WORKDIR /workspace
#RUN echo $(ls /tmp/dsv/)
#RUN python /tmp/dsv/setup.py install
#USER root

RUN chmod 777 /workspace/
# RUN chmod +x /workspace/dsv/__main__.py \
#     & echo 'export PATH=${PATH}:/workspace/dsv/' >> ~/.bashrc \
#     & echo 'alias dsv="__main__.py"' >> ~/.bashrc
# RUN source ~/.bashrc
