apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "common.fullname" . }}
  labels:
    app: {{ include "common.name" . }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ include "common.name" . }}
  template:
    metadata:
      labels:
        app: {{ include "common.name" . }}
    spec:
      volumes:
        - name: bp-storage
          persistentVolumeClaim:
            claimName: {{ include "common.fullname" . }}
      initContainers:
        - name: fix-permissions
          image: busybox
          command: ["sh", "-c", "chown -R 999:999 /botpress/data /botpress/log /botpress/pre-trained /botpress/stop-words"]
          volumeMounts:
            - name: bp-storage
              mountPath: /botpress/data
            - name: bp-storage
              mountPath: /botpress/log
            - name: bp-storage
              mountPath: /botpress/pre-trained
            - name: bp-storage
              mountPath: /botpress/stop-words
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: {{ .Values.service.targetPort }}
          env:
            - name: DATABASE_URL
              value: "postgres://{{ .Values.postgresql.auth.username }}:{{ .Values.postgresql.auth.password }}@{{ .Release.Name }}-postgresql/{{ .Values.postgresql.auth.database }}"
            {{- range $key, $value := .Values.env }}
            - name: {{ $key }}
              value: "{{ $value }}"
            {{- end }}
          securityContext:
            runAsUser: 999
            runAsGroup: 999
          volumeMounts:
            - name: bp-storage
              mountPath: /botpress/data
            - name: bp-storage
              mountPath: /botpress/pre-trained
            - name: bp-storage
              mountPath: /botpress/stop-words
            - name: bp-storage
              mountPath: /botpress/log

