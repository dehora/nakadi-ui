module Pages.SubscriptionDetails.Help exposing (authorization, consumerGroup, createdAt, cursors, eventTypes, owningApplication, readFrom, subscription, subscriptionStats)

import Config exposing (appPreffix)
import Helpers.UI exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


subscription : List (Html msg)
subscription =
    [ text "Subscriptions (also knows as the high-level API) allow clients to consume "
    , text "events, where the Nakadi server stores offsets and automatically manages "
    , text "reblancing of partitions across consumer clients. This allows clients to avoid "
    , text "managing stream state locally"
    , newline
    , man "#using_consuming-events-hila"
    , newline
    , newline
    , text "Id of subscription that was created. Generated by Nakadi, should not be specified when"
    , text " creating subscription."
    , newline
    , bold "Note: "
    , i []
        [ text "The subscription is identified by its key parameters (owning_application, event_types, consumer_group). If "
        , text "this endpoint is invoked several times with the same key subscription properties in body (order of even_types is "
        , text "not important) - the subscription will be created only once and for all other calls it will just return "
        , text "the subscription that was already created."
        ]
    , newline
    , spec "#/subscriptions_get"
    ]


owningApplication : List (Html msg)
owningApplication =
    [ text "The id of application owning the subscription."
    , newline
    , bold "Example"
    , text ": "
    , mono ("\"" ++ appPreffix ++ "price-service\"")
    , newline
    , bold "Key: "
    , mono "owning_application"
    , bold "required"
    , newline
    , spec "#/subscriptions_get*owning_application"
    ]


eventTypes : List (Html msg)
eventTypes =
    [ text "EventTypes to subscribe to."
    , newline
    , text "The order is not important. Subscriptions that differ only by the order of EventTypes will be "
    , text "considered the same and will have the same id."
    , newline
    , newline
    , bold "Example"
    , text ": "
    , mono "[\"market.price-service.update\"]"
    , newline
    , newline
    , bold "Key: "
    , mono "event_types"
    , bold "required"
    , newline
    , spec "#/subscriptions_get*event_type"
    ]


consumerGroup : List (Html msg)
consumerGroup =
    [ text "The value describing the use case of this subscription."
    , newline
    , text "In general that is an additional identifier used to distinguish subscriptions having the same "
    , mono "owning_application"
    , text " and "
    , mono "event_types"
    , text "."
    , newline
    , newline
    , bold "Key: "
    , mono "consumer_group"
    , bold "optional"
    , newline
    , bold "Default: "
    , mono "default"
    , newline
    , spec "#definition_Subscription*consumer_group"
    ]


cursors : List (Html msg)
cursors =
    [ text "List of cursors to start reading from."
    , newline
    , text "This property is required when `read_from` = `cursors`."
    , text "The initial cursors should cover all partitions of subscription."
    , newline
    , bold "Key: "
    , mono "initial_cursors"
    , bold "writeonly"
    , newline
    , spec "#definition_Subscription*initial_cursors"
    ]


readFrom : List (Html msg)
readFrom =
    [ text "Position to start reading events from."
    , newline
    , text "Currently supported values:"
    , newline
    , text "- "
    , mono "begin"
    , text " read from the oldest available event."
    , newline
    , text "- "
    , mono "end"
    , text " read from the most recent offset."
    , newline
    , text "- "
    , mono "cursors"
    , text " read from cursors provided in `initial_cursors` property."
    , text " Applied when the client starts reading from a subscription."
    , newline
    , newline
    , bold "Key: "
    , mono "read_from"
    , bold "optional"
    , newline
    , bold "Default: "
    , mono "end"
    , newline
    , spec "#definition_Subscription*read_from"
    ]


createdAt : List (Html msg)
createdAt =
    [ text "Timestamp of creation of the subscription."
    , newline
    , text "This is generated by Nakadi. It should not be "
    , text "specified when creating subscription and sending it may result in a client error."
    , newline
    , bold "Key: "
    , mono "created_at"
    , bold "readonly"
    , newline
    , spec "#definition_Subscription*created_at"
    ]


subscriptionStats : List (Html msg)
subscriptionStats =
    [ text "Statistics of specified subscription"
    , newline
    , man "#subscription-statistics"
    , newline
    , text "Each event type record in a subscription contains a list of partition statistics"
    , newline
    , text "- "
    , mono "partition"
    , text ": Index of partition"
    , newline
    , text "- "
    , mono "state"
    , text ": The state of this partition in the current subscription. The following values are possible:"
    , p [ style "margin" "0 0 0 20px" ]
        [ mono "unassigned"
        , text "the partition is not assigned to any client;"
        , newline
        , mono "reassigning"
        , text "the partition is reassigning from one client to another;"
        , newline
        , mono "assigned"
        , text "the partition is assigned to a client."
        ]
    , text "- "
    , mono "unconsumed_events"
    , text ": The amount of events in this partition that are not yet consumed within this subscription. May be not "
    , text "determined at the moment when no events were yet consumed from the partition in this subscription (in "
    , text "that case the property will be absent)."
    , newline
    , text "- "
    , mono "stream_id"
    , text ": The id of the stream that consumes data from this partition"
    , newline
    , spec "#/subscriptions/subscription_id/stats_get"
    ]


authorization : List (Html msg)
authorization =
    [ text "Authorization section of a Subscription."
    , text " This section defines two access control lists: one for consuming events and committing cursors (‘readers’),"
    , text " and one for administering a subscription (‘admins’). Regardless of the values of the authorization"
    , text " properties, administrator accounts will always be authorized."
    , newline
    , newline
    , mono "readers"
    , text " - for consuming events"
    , newline
    , text "An array of subject attributes that are required for reading events and committing cursors to this subscription."
    , newline
    , newline
    , mono "admins"
    , text " - for administering a subscription"
    , newline
    , text "An array of subject attributes that are required for delete/update the subscription."
    , newline
    , newline
    , man "#definition_SubscriptionAuthorization"
    , newline
    , newline
    , bold "Key: "
    , mono "authorization"
    , bold "optional"
    , newline
    , man "#using_authorization"
    ]
