# FROM node:14.16.0-alpine3.13 AS build-stage
# WORKDIR /app/build
# # COPY package*.json ./
# # RUN npm install
# COPY ./build .
# # RUN npm run build

# FROM nginx:1.12-alpine
# RUN addgroup app && adduser -S -G app app
# USER app

# COPY --from=build-stage /app/build /usr/share/nginx/html
# EXPOSE 80 
# ENTRYPOINT [ "nginx", "-g", "daemon off;" ]

# Install dependencies only when needed
FROM node:14.16.0-alpine3.13 AS deps
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk update && apk add --no-cache libc6-compat && apk add git
WORKDIR /app
COPY package.json ./
RUN yarn install

# Rebuild the source code only when needed
FROM node:alpine AS builder
RUN apk add git
WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules
RUN yarn build && yarn install

# Production image, copy all the files and run next
FROM node:14.16.0-alpine3.13 AS runner
WORKDIR /app

ENV NODE_ENV production

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

# You only need to copy next.config.js if you are NOT using the default configuration
# COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

USER nextjs

EXPOSE 3000

# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Uncomment the following line in case you want to disable telemetry.
# ENV NEXT_TELEMETRY_DISABLED 1

CMD ["yarn", "start"]