FROM python:alpine3.14
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
EXPOSE 80
ARG USER=voteuser
ENV HOME /home/$USER
RUN adduser -D $USER && \
    chown -R $USER:$USER /app
RUN apk add --no-cache curl
HEALTHCHECK --interval=30s --timeout=10s --retries=2 --start-period=20s \
  CMD curl -f http://localhost:80/ || exit 1
USER $USER
EXPOSE 80
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
