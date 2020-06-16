package com.td.adtflutter.talkingdata_adtracking;

import android.content.Context;

import com.tendcloud.appcpa.Order;
import com.tendcloud.appcpa.ShoppingCart;
import com.tendcloud.appcpa.TDSearch;
import com.tendcloud.appcpa.TDTransaction;
import com.tendcloud.appcpa.TalkingDataAppCpa;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/**
 * TalkingdataAdtrackingPlugin
 */
public class TalkingdataAdtrackingPlugin implements MethodCallHandler {
    private Context context;

    private TalkingdataAdtrackingPlugin(Context context) {
        this.context = context;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "talkingdata_adtracking");
        channel.setMethodCallHandler(new TalkingdataAdtrackingPlugin(registrar.context().getApplicationContext()));
    }

    public static void init(Context ctx, String adtAppID, String adtChannelID) {
        TalkingDataAppCpa.init(ctx, adtAppID, adtChannelID);
    }

    public static void init(Context ctx, String adtAppID, String adtChannelID, String adtCustom) {
        TalkingDataAppCpa.init(ctx, adtAppID, adtChannelID, adtCustom);
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "getDeviceID":
                result.success(TalkingDataAppCpa.getDeviceId(context));
                break;
            case "onRegister":
                TalkingDataAppCpa.onRegister((String) call.argument("account"));
                break;
            case "onRegisterWithInvitationCode":
                TalkingDataAppCpa.onRegister((String) call.argument("account"),
                        (String) call.argument("invitationCode"));
                break;
            case "onLogin":
                TalkingDataAppCpa.onLogin((String) call.argument("account"));
                break;
            case "onCreateCard":
                TalkingDataAppCpa.onCreateCard((String) call.argument("account"),
                        (String) call.argument("method"),
                        (String) call.argument("content"));
                break;
            case "onReceiveDeepLink":
                TalkingDataAppCpa.onReceiveDeepLink((String) call.argument("link"));
                break;
            case "onFavorite":
                TalkingDataAppCpa.onFavorite((String) call.argument("category"),
                        (String) call.argument("content"));
                break;
            case "onShare":
                TalkingDataAppCpa.onShare((String) call.argument("account"),
                        (String) call.argument("content"));
                break;
            case "onPunch":
                TalkingDataAppCpa.onPunch((String) call.argument("account"),
                        (String) call.argument("punchId"));
                break;
            case "onSearch":
                TDSearch tdSearch = TDSearch.createAdSearch();
                tdSearch.setCategory((String) call.argument("category"));
                tdSearch.setContent((String) call.argument("content"));
                tdSearch.setItemId((String) call.argument("itemId"));
                tdSearch.setItemLocationId((String) call.argument("itemLocationId"));
                tdSearch.setDestination((String) call.argument("destination"));
                tdSearch.setOrigin((String) call.argument("origin"));
                tdSearch.setStartDate(callTransInt(call, "startDate"));
                tdSearch.setEndDate(callTransInt(call, "endDate"));
                TalkingDataAppCpa.onSearch(tdSearch);
                break;
            case "onReservation":
                TalkingDataAppCpa.onReservation((String) call.argument("account"),
                        (String) call.argument("reservationId"),
                        (String) call.argument("category"),
                        callTransInt(call, "amount"),
                        (String) call.argument("term"));
                break;
            case "onBooking":
                TalkingDataAppCpa.onBooking((String) call.argument("account"),
                        (String) call.argument("bookingId"),
                        (String) call.argument("category"),
                        callTransInt(call, "amount"),
                        (String) call.argument("content"));
                break;
            case "onContact":
                TalkingDataAppCpa.onContact((String) call.argument("account"),
                        (String) call.argument("content"));
                break;
            case "onViewItemWithCategory":
                TalkingDataAppCpa.onViewItem((String) call.argument("category"),
                        (String) call.argument("itemId"),
                        (String) call.argument("name"),
                        callTransInt(call, "unitPrice"));
                break;
            case "onViewShoppingCart":
                ShoppingCart shoppingCart = ShoppingCart.createShoppingCart();
                List<Map> shoppingCartDetails = call.argument("shoppingCartDetails");
                for (int i = 0; i < shoppingCartDetails.size(); i++) {
                    Map map = shoppingCartDetails.get(i);
                    shoppingCart.addItem(
                            (String) map.get("itemID"),
                            (String) map.get("category"),
                            (String) map.get("name"),
                            mapTransInt(map, "unitPrice"),
                            mapTransInt(map, "amount")
                    );
                }
                TalkingDataAppCpa.onViewShoppingCart(shoppingCart);
                break;
            case "onAddItemToShoppingCart":
                TalkingDataAppCpa.onAddItemToShoppingCart((String) call.argument("itemID"),
                        (String) call.argument("category"),
                        (String) call.argument("name"),
                        callTransInt(call, "unitPrice"),
                        callTransInt(call, "amount"));
                break;
            case "onPlaceOrder":
                TalkingDataAppCpa.onPlaceOrder(
                        (String) call.argument("accountID"),
                        getOrderFromFlutter(call));
                break;
            case "onPay1":
                TalkingDataAppCpa.onPay(
                        (String) call.argument("account"),
                        (String) call.argument("orderId"),
                        callTransInt(call, "amount"),
                        (String) call.argument("currencyType"),
                        (String) call.argument("payType"));
                break;
            case "onPay2":
                TalkingDataAppCpa.onPay(
                        (String) call.argument("account"),
                        (String) call.argument("orderId"),
                        callTransInt(call, "amount"),
                        (String) call.argument("currencyType"),
                        (String) call.argument("payType"),
                        getOrderFromFlutter(call));
                break;
            case "onPay3":
                TalkingDataAppCpa.onPay(
                        (String) call.argument("account"),
                        (String) call.argument("orderId"),
                        callTransInt(call, "amount"),
                        (String) call.argument("currencyType"),
                        (String) call.argument("payType"),
                        (String) call.argument("itemId"),
                        callTransInt(call, "itemCount"));
                break;
            case "onLearn":
                TalkingDataAppCpa.onLearn(
                        (String) call.argument("account"),
                        (String) call.argument("course"),
                        callTransInt(call, "begin"),
                        callTransInt(call, "duration"));
                break;
            case "onRead":
                TalkingDataAppCpa.onRead(
                        (String) call.argument("account"),
                        (String) call.argument("book"),
                        callTransInt(call, "begin"),
                        callTransInt(call, "duration"));
                break;
            case "onBrowse":
                TalkingDataAppCpa.onBrowse(
                        (String) call.argument("account"),
                        (String) call.argument("content"),
                        callTransInt(call, "begin"),
                        callTransInt(call, "duration"));
                break;
            case "onTransaction":
                TDTransaction transaction = TDTransaction.createTDTransaction();
                transaction.setTransactionId((String) call.argument("transactionId"));
                transaction.setCategory((String) call.argument("category"));
                transaction.setAmount(callTransInt(call, "amount"));
                transaction.setPersonA((String) call.argument("personA"));
                transaction.setPersonB((String) call.argument("personB"));
                transaction.setStartDate(callTransInt(call, "startDate"));
                transaction.setEndDate(callTransInt(call, "endDate"));
                transaction.setCurrencyType((String) call.argument("currencyType"));
                transaction.setContent((String) call.argument("content"));
                TalkingDataAppCpa.onTransaction(
                        (String) call.argument("account"),
                        transaction);

                break;
            case "onCredit":
                TalkingDataAppCpa.onCredit(
                        (String) call.argument("account"),
                        callTransInt(call, "amount"),
                        (String) call.argument("content"));
                break;
            case "onChargeBack":
                TalkingDataAppCpa.onChargeBack(
                        (String) call.argument("account"),
                        (String) call.argument("orderId"),
                        (String) call.argument("reason"),
                        (String) call.argument("type"));
                break;
            case "onCreateRole":
                TalkingDataAppCpa.onCreateRole((String) call.argument("name"));
                break;
            case "onTrialFinished":
                TalkingDataAppCpa.onTrialFinished(
                        (String) call.argument("account"),
                        (String) call.argument("content"));
                break;
            case "onGuideFinished":
                TalkingDataAppCpa.onGuideFinished(
                        (String) call.argument("account"),
                        (String) call.argument("content"));
                break;
            case "onPreviewFinished":
                TalkingDataAppCpa.onPreviewFinished(
                        (String) call.argument("account"),
                        (String) call.argument("content"));
                break;
            case "onFreeFinished":
                TalkingDataAppCpa.onFreeFinished(
                        (String) call.argument("account"),
                        (String) call.argument("content"));
                break;
            case "onLevelPass":
                TalkingDataAppCpa.onLevelPass(
                        (String) call.argument("account"),
                        (String) call.argument("levelId"));
                break;
            case "onAchievementUnlock":
                TalkingDataAppCpa.onAchievementUnlock(
                        (String) call.argument("account"),
                        (String) call.argument("achievementId"));
                break;
            case "onOrderPaySucc":
                TalkingDataAppCpa.onOrderPaySucc(
                        (String) call.argument("account"),
                        (String) call.argument("orderId"),
                        callTransInt(call, "amount"),
                        (String) call.argument("currencyType"),
                        (String) call.argument("payType"));
                break;
            case "onCustEvent1":
                TalkingDataAppCpa.onCustEvent1();
                break;
            case "onCustEvent2":
                TalkingDataAppCpa.onCustEvent2();
                break;
            case "onCustEvent3":
                TalkingDataAppCpa.onCustEvent3();
                break;
            case "onCustEvent4":
                TalkingDataAppCpa.onCustEvent4();
                break;
            case "onCustEvent5":
                TalkingDataAppCpa.onCustEvent5();
                break;
            case "onCustEvent6":
                TalkingDataAppCpa.onCustEvent6();
                break;
            case "onCustEvent7":
                TalkingDataAppCpa.onCustEvent7();
                break;
            case "onCustEvent8":
                TalkingDataAppCpa.onCustEvent8();
                break;
            case "onCustEvent9":
                TalkingDataAppCpa.onCustEvent9();
                break;
            case "onCustEvent10":
                TalkingDataAppCpa.onCustEvent10();
                break;
        }
    }

    private Order getOrderFromFlutter(MethodCall call) {
        Order order = null;
        try {
            String orderID = call.argument("orderID");
            int totalPrice = callTransInt(call, "totalPrice");
            String currencyType = call.argument("currencyType");

            List orderDetails = call.argument("orderDetails");

            order = Order.createOrder(orderID, totalPrice, currencyType);
            for (int i = 0; i < orderDetails.size(); i++) {
                Map<String, Object> map = (Map) orderDetails.get(i);
                String id = String.valueOf(map.get("itemID"));
                String category = String.valueOf(map.get("category"));
                String name = String.valueOf(map.get("name"));
                int unitPrice = mapTransInt(map, "unitPrice");
                int amount = mapTransInt(map, "amount");
                order.addItem(id, category, name, unitPrice, amount);
            }
        } catch (Throwable t) {
            t.printStackTrace();
        }

        return order;
    }

    private int callTransInt(MethodCall call, String dsc) {
        if (call.argument(dsc) != null) {
            return (int) call.argument(dsc);
        } else {
            return 0;
        }
    }

    private int mapTransInt(Map map, String dsc) {
        if (map.get(dsc) != null) {
            return (int) map.get(dsc);
        } else {
            return 0;
        }
    }
}
