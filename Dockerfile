FROM ubuntu:14.04

# Set the default shell for executing commands.
SHELL ["/bin/bash", "-c"]

ADD db_commands.txt setup_irods_41.sh \
    irods-database-plugin-postgres-1.12-ubuntu14-x86_64.deb \
    irods-icat-4.1.12-ubuntu14-x86_64.deb \
    /

RUN apt-get update && \
    apt-get install -y wget tig git vim sudo postgresql

# Setup ICAT database.
RUN service postgresql start && su - postgres -c "psql -f /db_commands.txt" && \
    dpkg -i /irods-icat-4.1.12-ubuntu14-x86_64.deb /irods-database-plugin-postgres-1.12-ubuntu14-x86_64.deb ; \
    apt install -y -f

WORKDIR /
#ADD run_irods.sh /run_irods.sh
#RUN chmod u+x /run_irods.sh
#ENTRYPOINT ["/bin/bash","-c"]
CMD [ "/bin/bash" ]