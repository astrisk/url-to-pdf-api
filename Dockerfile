#############################################
# Step 1 : Builder image
#
FROM fangruo/node-ubuntu:10.16.5 AS builder

COPY . .
RUN npm install

#############################################
# Step 2 : Release image
#
FROM fangruo/node-ubuntu:10.16.5 AS release

ENV NODE_ENV production
ENV ALLOW_HTTP true
ENV PORT 8080

COPY --from=builder  /workdir/node_modules ./node_modules
COPY --from=builder  /workdir/package.json ./package.json
COPY --from=builder  /workdir/src          ./src

EXPOSE 8080

# Start the app
CMD ["node", "src/index.js"]
