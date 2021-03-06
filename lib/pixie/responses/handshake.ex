defmodule Pixie.Response.Handshake do
  @version "1.0"
  defstruct channel: "/meta/handshake", version: @version, supported_connection_types: HashSet.new, client_id: nil, error: nil, minimum_version: nil, advice: nil, ext: nil, id: nil, auth_successful: nil
  import Pixie.Utils.Response

  @moduledoc """
  Convert an incoming `Pixie.Message.Handshake` into a response.

      Success Response                             Failed Response
      MUST include:  * channel                     MUST include:  * channel
                     * version                                    * successful
                     * supportedConnectionTypes                   * error
                     * clientId                    MAY include:   * supportedConnectionTypes
                     * successful                                 * advice
      MAY include:   * minimumVersion                             * version
                     * advice                                     * minimumVersion
                     * ext                                        * ext
                     * id                                         * id
                     * authSuccessful

  The struct contains the following keys:

    - `:channel` always `"/meta/handshake"`.
    - `:version` the Bayeux protocol version supported by the server.
    - `:supported_connection_types` the union of transports between the
      client's supported connection types and the server's enabled types.
    - `:client_id` the client ID generated by the server during handshake.
    - `:error` an error message to send to the client explaining why the
      request cannot proceed. Optional.
    - `:minimum_version` the minimum Bayeux protocol version supported by the
      server.
    - `:advice` advice from the server about how to handle timeouts, polling
      intervals, etc. See
      [the Bayeux protocol](http://svn.cometd.org/trunk/bayeux/bayeux.html#toc_32)
      for more information.
    - `:ext` an arbitrary map of data the server sends for use in extensions
      (usually authentication information, etc). Optional.
    - `:id` a message ID generated by the client. Optional.
    - `:auth_successful` either `true` or `false`. Optional.
  """

  @doc """
  Create a `Pixie.Response.Handshake` struct based on some fields from the
  incoming message.
  """
  def init %Pixie.Message.Handshake{}=message do
    %Pixie.Response.Handshake{}
      |> put(message, :id)
  end
end
