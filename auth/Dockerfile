FROM kibana:5.2.2

RUN apt-get update && apt-get install -y git --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:/usr/share/kibana/node/bin

# Install c3 charts
RUN cd /usr/share/kibana/plugins && git clone --depth=1 https://github.com/mstoyano/kbn_c3js_vis.git c3_charts \
    && cd c3_charts && rm -rf .git \
    && sed -ri "s/(\"version\":).*,$/\1 \"$KIBANA_VERSION\",/" package.json \
    && npm install

# Install time picker plugin
#RUN cd /usr/share/kibana/plugins \
#    && git clone --depth=1 https://github.com/nreese/kibana-time-plugin \
#    && cd kibana-time-plugin && rm -rf .git \
#    && sed -ri "s/(\"version\":).*,$/\1 \"$KIBANA_VERSION\",/" package.json \
#    && npm install

# This will also optimize bundles etc. So do it rather late
RUN /usr/share/kibana/bin/kibana-plugin install x-pack

COPY entrypoint.sh /
CMD ["kibana"]
ENTRYPOINT ["/entrypoint.sh"]
