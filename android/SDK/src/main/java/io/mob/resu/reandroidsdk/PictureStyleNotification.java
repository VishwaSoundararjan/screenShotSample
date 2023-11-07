package io.mob.resu.reandroidsdk;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.DataSource;
import com.bumptech.glide.load.engine.GlideException;
import com.bumptech.glide.request.RequestListener;
import com.bumptech.glide.request.target.CustomTarget;
import com.bumptech.glide.request.target.Target;
import com.bumptech.glide.request.transition.Transition;

import org.json.JSONObject;

import io.mob.resu.reandroidsdk.error.ExceptionTracker;
import io.mob.resu.reandroidsdk.error.Log;


class PictureStyleNotification {

    private final Intent intent;
    private final Context mContext;
    private final String imageUrl;
    private final Bitmap bitmap = null;
    private int position;

    PictureStyleNotification(Context context, Intent intent) {
        super();
        this.mContext = context;
        this.imageUrl = intent.getStringExtra("url");
        this.intent = intent;
        //new MyAsync().execute();
        LoadImage(context, imageUrl);
    }

    PictureStyleNotification(Context context, Intent intent, String imageUrl, int position) {
        super();
        this.mContext = context;
        this.intent = intent;
        this.imageUrl = imageUrl;
        this.position = position;
        //new MyAsync().execute();
        try {
            LoadImage(context, imageUrl);
        } catch (Exception e) {

        }
    }

   /* private class MyAsync extends AsyncTask<Void, Void, Bitmap> {

        @Override
        protected Bitmap doInBackground(Void... params) {

            try {


                URL url = new URL(imageUrl);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setDoInput(true);
                connection.connect();
                InputStream input = connection.getInputStream();
                return BitmapFactory.decodeStream(input);

               *//* InputStream input = new java.net.URL(imageUrl).openStream();
                // Decode Bitmap
                return  BitmapFactory.decodeStream(input);*//*
            } catch (IOException e) {
                ExceptionTracker.track(e);
                return null;
            }

        }

        @Override
        protected void onPostExecute(Bitmap result) {
            super.onPostExecute(result);
            try {
                if (result != null) {
                    if (intent.hasExtra("carousel") && intent.getStringExtra("pushType").equalsIgnoreCase("1")) {
                        new AppNotification().carouselNotification(mContext, intent, position, result);
                    } else {
                        new AppNotification().showNotification(mContext, intent, result);
                    }
                } else {
                    new AppNotification().showNotification(mContext, intent, null);
                }

            } catch (Exception e) {
                ExceptionTracker.track(e);
            }
        }
    }*/

    public void LoadImage(final Context context, final String imageUrl) {
        try {
            Glide.with(context)
                    .asBitmap()
                    .load(imageUrl)
                    .listener(new RequestListener<Bitmap>() {
                        @Override
                        public boolean onLoadFailed(@Nullable GlideException e, Object model, Target<Bitmap> target, boolean isFirstResource) {
                            // Log the GlideException here (locally or with a remote logging framework):
                            try {
                                JSONObject jsonObject = new JSONObject();
                                jsonObject.put("Url", "" + imageUrl);
                                jsonObject.put("Error", "" + e.getLocalizedMessage());
                                AppLifecyclePresenter.getInstance().userEventTracking(context, jsonObject, "ImageLoadFailed");
                                Log.e("onLoadFailed", "" + e.getLocalizedMessage());
                            } catch (Exception e2) {

                            }
                            return false;
                        }

                        @Override
                        public boolean onResourceReady(Bitmap resource, Object model, Target<Bitmap> target, DataSource dataSource, boolean isFirstResource) {
                            Log.e("onResourceReady", "Image Downloaded");
                            return false;
                        }
                    })

                    .into(new CustomTarget<Bitmap>() {
                        @Override
                        public void onResourceReady(@NonNull Bitmap resource, @Nullable Transition<? super Bitmap> transition) {
                            //largeIcon
                            try {
                                present(resource);
                            } catch (Exception e) {
                                ExceptionTracker.track(e);
                                present(null);
                            }
                        }

                        @Override
                        public void onLoadCleared(@Nullable Drawable placeholder) {
                        }

                        @Override
                        public void onLoadFailed(@Nullable Drawable errorDrawable) {
                            super.onLoadFailed(errorDrawable);
                            present(null);
                        }
                    })

            ;
        } catch (Exception e) {
            present(null);
        }
    }

    private void present(Bitmap bitmap) {
        try {
            if (bitmap != null) {
                if (intent.hasExtra("carousel") && intent.getStringExtra("pushType").equalsIgnoreCase("1")) {
                    new AppNotification().carouselNotification(mContext, intent, position, bitmap);
                } else {
                    new AppNotification().showNotification(mContext, intent, bitmap);
                }
            } else {
                if (intent.hasExtra("carousel") && intent.getStringExtra("pushType").equalsIgnoreCase("1")) {
                    new AppNotification().carouselNotification(mContext, intent, position, null);
                } else {
                    new AppNotification().showNotification(mContext, intent, null);
                }
            }

        } catch (Exception e1) {
            ExceptionTracker.track(e1);
        }
    }
}
