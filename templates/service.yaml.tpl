apiVersion: v1
kind: Service
metadata:
  name: {{ include "common.fullname" . }}
spec:
  type: {{ .Values.service.type }}
  selector:
    app: {{ include "common.name" . }}
  ports:
    - protocol: TCP
      port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.targetPort }}