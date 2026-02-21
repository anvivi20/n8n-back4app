FROM n8nio/n8n:latest

# Set user root untuk install tambahan
USER root

# Environment variables
ENV N8N_PORT=5678
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=https
ENV GENERIC_TIMEZONE=Asia/Jakarta
ENV TZ=Asia/Jakarta
ENV N8N_SECURE_COOKIE=false
ENV N8N_RUNNERS_ENABLED=false

# Buat folder data
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# Kembali ke user node (keamanan)
USER node

# Expose port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD wget --spider -q http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n", "start"] 