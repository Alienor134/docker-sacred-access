# Use official Jupyter data science image (includes pandas, numpy, matplotlib, scipy, scikit-learn, etc.)
FROM quay.io/jupyter/datascience-notebook:latest

# Switch to root to install packages and set permissions
USER root

# Copy requirements file
COPY workshop-files/requirements.txt /tmp/requirements.txt

# Install Python packages from requirements
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Copy workshop files to the work directory (where JupyterHub expects them)
COPY workshop-files/ ${HOME}/work/

# Fix ownership and permissions for all files in jovyan's home directory
RUN fix-permissions ${HOME} && \
    fix-permissions /home/jovyan/work/

# Switch back to jovyan user (default Jupyter user)
USER $NB_UID

# The base image already sets up the correct CMD for JupyterHub compatibility
