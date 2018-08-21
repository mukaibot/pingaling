defmodule Api.Resources.Manifests.V1.NotificationPolicy do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Api.NotificationChannels.ChannelConfiguration
  alias Api.NotificationChannels.NotificationPolicy
  alias Api.Repo
  alias Api.Resources.Endpoint

  @mandatory_keys [:name, :endpoint, :channel]

  @doc false
  def changeset(npolicy, attrs) do
    npolicy
    |> cast(
         attrs,
         [
           :name,
           :description,
           :limit_sending,
           :monday_start,
           :monday_end,
           :tuesday_start,
           :tuesday_end,
           :wednesday_start,
           :wednesday_end,
           :thursday_start,
           :thursday_end,
           :friday_start,
           :friday_end,
           :saturday_start,
           :saturday_end,
           :sunday_start,
           :sunday_end
         ]
       )
    |> put_assoc(:endpoint, attrs.endpoint)
    |> put_assoc(:notification_channel, attrs.channel)
    |> validate_required(:name)
    |> foreign_key_constraint(:endpoint_id)
    |> foreign_key_constraint(:notification_channel)
    |> unique_constraint(:name)
  end

  def apply(spec) do
    validate_spec(spec)
  end

  defp upsert(spec) do
    npolicy = Repo.one(
      from np in NotificationPolicy,
      where: np.name == ^spec["name"],
      limit: 1,
      preload: [:endpoint, :notification_channel]
    )

    if npolicy == nil do
      %NotificationPolicy{}
      |> changeset(attrs_from_spec(spec))
      |> Repo.insert!
      {:created, %{message: "Created Slack channel #{spec["name"]}"}}
    else
      npolicy
      |> changeset(attrs_from_spec(spec))
      |> Repo.update!
      {:ok, %{message: "Updated Slack channel #{spec["name"]}"}}
    end
  end

  defp attrs_from_spec(spec) do
    %{
      name: Map.get(spec, "name"),
      description: Map.get(spec, "description"),
      endpoint: Repo.get_by!(Endpoint, name: spec["endpoint"]),
      channel: Repo.get_by!(ChannelConfiguration, name: spec["channel"])
    }
  end

  defp validate_spec(spec) do
    with {:ok, spec} <- validate_mandatory_keys(spec),
         {:ok, spec} <- validate_name(spec)
      do
      upsert(spec)
    else
      err -> err
    end
  end

  defp validate_mandatory_keys(spec) do
    spec_keys = Map.keys(spec)
                |> Enum.sort
    mandatory_keys_as_string = @mandatory_keys
                               |> Enum.map(fn key -> Atom.to_string(key) end)
    missing_keys = mandatory_keys_as_string -- spec_keys

    if missing_keys == [] do
      {:ok, spec}
    else
      {
        :bad_request,
        %{
          message: "Missing #{
            missing_keys
            |> inspect
          }"
        }
      }
    end
  end

  defp validate_name(spec) do
    cond do
      spec
      |> Map.get("name") == nil ->
        {:bad_request, %{message: "spec.name cannot be nil"}}
      spec
      |> Map.get("name")
      |> String.trim == "" ->
        {:bad_request, %{message: "spec.name cannot be blank"}}
      true ->
        {:ok, spec}
    end
  end
end

