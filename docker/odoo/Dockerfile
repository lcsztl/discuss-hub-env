# Stage 1: clone required repos and prepare /mnt/extra-addons
FROM alpine/git AS build

ARG OCA_SOCIAL_REF=18.0
ARG OCA_HELPDESK_REF=18.0
ARG DISCUSS_HUB_GIT_URL=https://github.com/lcsztl/discuss-hub.git
ARG DISCUSS_HUB_REF=18.0

RUN mkdir -p /mnt/repositories /mnt/extra-addons
WORKDIR /mnt/repositories

RUN git clone --depth 1 --branch "${OCA_SOCIAL_REF}" https://github.com/OCA/social.git oca-social \
 && git clone --depth 1 --branch "${OCA_HELPDESK_REF}" https://github.com/OCA/helpdesk.git oca-helpdesk \
 && git clone --depth 1 --branch "${DISCUSS_HUB_REF}" "${DISCUSS_HUB_GIT_URL}" discuss-hub

# Copy only the addons we need to keep the image smaller and predictable.
RUN cp -r \
    oca-social/mail_gateway \
    oca-social/mail_gateway_whatsapp \
    oca-social/mail_gateway_telegram \
    oca-helpdesk/helpdesk_mgmt \
    discuss-hub/mail_discuss_hub \
    discuss-hub/mail_discuss_hub_crm \
    discuss-hub/mail_discuss_hub_gateway \
    discuss-hub/mail_discuss_hub_gateway_devtools \
    discuss-hub/mail_discuss_hub_helpdesk_mgmt \
    discuss-hub/mail_gateway_fix \
    discuss-hub/mail_gateway_whatsapp_common \
    discuss-hub/mail_gateway_whatsapp_evolution_api \
    discuss-hub/mail_gateway_whatsapp_evolution_api_chatwoot \
    discuss-hub/mail_gateway_whatsapp_evolution_api_manager \
    discuss-hub/mail_gateway_whatsapp_waha \
    /mnt/extra-addons/

RUN rm -rf /mnt/repositories

# Stage 2: final image based on official Odoo
FROM odoo:18

ENV ODOO_USER=odoo \
    ADDONS_DIR=/mnt/extra-addons

USER root

RUN mkdir -p "${ADDONS_DIR}"
COPY --from=build /mnt/extra-addons/ ${ADDONS_DIR}/

# This repo's "meta" module (installs everything)
COPY addons/mail_discuss_hub_full ${ADDONS_DIR}/mail_discuss_hub_full

RUN chown -R "${ODOO_USER}:${ODOO_USER}" "${ADDONS_DIR}" \
 && pip3 install --no-cache-dir --break-system-packages \
      redis \
      python-json-logger \
      statsd \
      boto \
      python-telegram-bot \
      lottie \
      cairosvg

USER ${ODOO_USER}

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
