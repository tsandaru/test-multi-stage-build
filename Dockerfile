FROM multistagepoc-base:latest as build 

WORKDIR /usr/src/app

COPY . .

RUN npm run build

FROM multistagepoc-prod as prod

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist ./dist

RUN chown node:node -R /usr/src/app/dist

USER node

CMD ["node","dist/main"]