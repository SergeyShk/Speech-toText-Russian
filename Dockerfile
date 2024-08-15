# Dockerfile для сборки образа проекта распознавания речи
FROM pykaldi/pykaldi

# Настройка окружения
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/kaldi/src/featbin:/kaldi/src/ivectorbin:/kaldi/src/online2bin:/kaldi/src/rnnlmbin:/kaldi/src/fstbin:$PATH
ENV LC_ALL C.UTF-8
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install -y llvm-8 ffmpeg
RUN LLVM_CONFIG=/usr/bin/llvm-config-8 pip3 install enum34 llvmlite numba

# Обновление pip, setuptools и wheel для избежания конфликтов
RUN pip install --upgrade pip setuptools wheel

# Установка typing_extensions и sox отдельно
RUN pip install typing_extensions
RUN pip install sox

# Установка остальных python-библиотек
RUN pip install \
        tqdm \
        pandas \
        matplotlib \
        seaborn \
        librosa \
        pysubs2 \
        flask \
        soundfile

# Копирование файлов проекта
WORKDIR /speech_recognition
RUN echo "cat motd" >> /root/.bashrc
COPY . ./
