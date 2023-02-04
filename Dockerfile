FROM node:19 AS builder
WORKDIR /app
COPY ./package.json ./package-lock.json ./
RUN npm ci
COPY ./ ./
RUN npm run build

FROM node:19-alpine AS runner
WORKDIR /app
ENV NODE_ENV production

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/static ./.next/static

CMD ["node", "server.js"]
