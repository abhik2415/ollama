services:
  ollama:
    image: ollama/ollama:latest  # Use the official Ollama image
    container_name: ollama
    ports:
      - "11434:11434"
    command: >
      ollama pull nomic-embed-text:latest &&
      ollama pull mistral:latest &&
      ollama serve
    networks:
      - ollama_network
    environment:
      - MODELS=nomic-embed-text:latest,mistral:latest

  chatbot:
    build: .
    container_name: chatbot
    environment:
      BASE_URL: http://ollama:11434
    ports:
      - "8501:8501"
    depends_on:
      - ollama
    networks:
      - ollama_network
networks:
    ollama_network:
       driver: bridge
