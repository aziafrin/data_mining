{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "e1ea1492",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:39.384553Z",
     "iopub.status.busy": "2022-05-08T16:38:39.382056Z",
     "iopub.status.idle": "2022-05-08T16:38:40.908164Z",
     "shell.execute_reply": "2022-05-08T16:38:40.906269Z"
    },
    "papermill": {
     "duration": 1.536006,
     "end_time": "2022-05-08T16:38:40.910914",
     "exception": false,
     "start_time": "2022-05-08T16:38:39.374908",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.1 ──\n",
      "\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.5     \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.6     \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.8\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.2.0     \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.1.2     \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.1\n",
      "\n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'mymensingh'"
      ],
      "text/latex": [
       "'mymensingh'"
      ],
      "text/markdown": [
       "'mymensingh'"
      ],
      "text/plain": [
       "[1] \"mymensingh\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(tidyverse) # metapackage of all tidyverse packages\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "062cd695",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:40.953333Z",
     "iopub.status.busy": "2022-05-08T16:38:40.921748Z",
     "iopub.status.idle": "2022-05-08T16:38:41.065923Z",
     "shell.execute_reply": "2022-05-08T16:38:41.063895Z"
    },
    "papermill": {
     "duration": 0.152823,
     "end_time": "2022-05-08T16:38:41.068421",
     "exception": false,
     "start_time": "2022-05-08T16:38:40.915598",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "randomForest 4.6-14\n",
      "\n",
      "Type rfNews() to see new features/changes/bug fixes.\n",
      "\n",
      "\n",
      "Attaching package: ‘randomForest’\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:dplyr’:\n",
      "\n",
      "    combine\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:ggplot2’:\n",
      "\n",
      "    margin\n",
      "\n",
      "\n"
     ]
    }
   ],
   "source": [
    "##Required packages\n",
    "library(rpart)\n",
    "library(rpart.plot)\n",
    "library(ggplot2)\n",
    "library(randomForest)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "2c964366",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:41.081362Z",
     "iopub.status.busy": "2022-05-08T16:38:41.079745Z",
     "iopub.status.idle": "2022-05-08T16:38:41.135652Z",
     "shell.execute_reply": "2022-05-08T16:38:41.133860Z"
    },
    "papermill": {
     "duration": 0.065216,
     "end_time": "2022-05-08T16:38:41.138423",
     "exception": false,
     "start_time": "2022-05-08T16:38:41.073207",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>ID</th><th scope=col>Station</th><th scope=col>Year</th><th scope=col>Month</th><th scope=col>TEM</th><th scope=col>DPT</th><th scope=col>WIS</th><th scope=col>HUM</th><th scope=col>SLP</th><th scope=col>T_RAN</th><th scope=col>A_RAIN</th><th scope=col>RAN</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1</td><td>Mymensingh</td><td>1960</td><td>1</td><td>16.9</td><td>11.3</td><td>2.0</td><td>73.39</td><td>1016.0</td><td> 15</td><td> 0.48</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>2</td><td>Mymensingh</td><td>1960</td><td>2</td><td>21.4</td><td>12.6</td><td>1.7</td><td>66.34</td><td>1013.0</td><td>  0</td><td> 0.00</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>3</td><td>Mymensingh</td><td>1960</td><td>3</td><td>24.1</td><td>14.9</td><td>2.3</td><td>64.13</td><td>1011.4</td><td> 69</td><td> 2.23</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>4</td><td>Mymensingh</td><td>1960</td><td>4</td><td>29.9</td><td>17.6</td><td>2.2</td><td>59.03</td><td>1007.1</td><td> 27</td><td> 0.90</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>5</td><td>Mymensingh</td><td>1960</td><td>5</td><td>29.6</td><td>23.2</td><td>2.4</td><td>73.45</td><td>1003.4</td><td>187</td><td> 6.03</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>6</td><td>Mymensingh</td><td>1960</td><td>6</td><td>28.2</td><td>24.1</td><td>2.0</td><td>84.03</td><td>1001.6</td><td>363</td><td>12.10</td><td>MHR</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 12\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & ID & Station & Year & Month & TEM & DPT & WIS & HUM & SLP & T\\_RAN & A\\_RAIN & RAN\\\\\n",
       "  & <int> & <chr> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1 & Mymensingh & 1960 & 1 & 16.9 & 11.3 & 2.0 & 73.39 & 1016.0 &  15 &  0.48 & NRT\\\\\n",
       "\t2 & 2 & Mymensingh & 1960 & 2 & 21.4 & 12.6 & 1.7 & 66.34 & 1013.0 &   0 &  0.00 & NRT\\\\\n",
       "\t3 & 3 & Mymensingh & 1960 & 3 & 24.1 & 14.9 & 2.3 & 64.13 & 1011.4 &  69 &  2.23 & LTR\\\\\n",
       "\t4 & 4 & Mymensingh & 1960 & 4 & 29.9 & 17.6 & 2.2 & 59.03 & 1007.1 &  27 &  0.90 & NRT\\\\\n",
       "\t5 & 5 & Mymensingh & 1960 & 5 & 29.6 & 23.2 & 2.4 & 73.45 & 1003.4 & 187 &  6.03 & LTR\\\\\n",
       "\t6 & 6 & Mymensingh & 1960 & 6 & 28.2 & 24.1 & 2.0 & 84.03 & 1001.6 & 363 & 12.10 & MHR\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 12\n",
       "\n",
       "| <!--/--> | ID &lt;int&gt; | Station &lt;chr&gt; | Year &lt;int&gt; | Month &lt;int&gt; | TEM &lt;dbl&gt; | DPT &lt;dbl&gt; | WIS &lt;dbl&gt; | HUM &lt;dbl&gt; | SLP &lt;dbl&gt; | T_RAN &lt;int&gt; | A_RAIN &lt;dbl&gt; | RAN &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1 | Mymensingh | 1960 | 1 | 16.9 | 11.3 | 2.0 | 73.39 | 1016.0 |  15 |  0.48 | NRT |\n",
       "| 2 | 2 | Mymensingh | 1960 | 2 | 21.4 | 12.6 | 1.7 | 66.34 | 1013.0 |   0 |  0.00 | NRT |\n",
       "| 3 | 3 | Mymensingh | 1960 | 3 | 24.1 | 14.9 | 2.3 | 64.13 | 1011.4 |  69 |  2.23 | LTR |\n",
       "| 4 | 4 | Mymensingh | 1960 | 4 | 29.9 | 17.6 | 2.2 | 59.03 | 1007.1 |  27 |  0.90 | NRT |\n",
       "| 5 | 5 | Mymensingh | 1960 | 5 | 29.6 | 23.2 | 2.4 | 73.45 | 1003.4 | 187 |  6.03 | LTR |\n",
       "| 6 | 6 | Mymensingh | 1960 | 6 | 28.2 | 24.1 | 2.0 | 84.03 | 1001.6 | 363 | 12.10 | MHR |\n",
       "\n"
      ],
      "text/plain": [
       "  ID Station    Year Month TEM  DPT  WIS HUM   SLP    T_RAN A_RAIN RAN\n",
       "1 1  Mymensingh 1960 1     16.9 11.3 2.0 73.39 1016.0  15    0.48  NRT\n",
       "2 2  Mymensingh 1960 2     21.4 12.6 1.7 66.34 1013.0   0    0.00  NRT\n",
       "3 3  Mymensingh 1960 3     24.1 14.9 2.3 64.13 1011.4  69    2.23  LTR\n",
       "4 4  Mymensingh 1960 4     29.9 17.6 2.2 59.03 1007.1  27    0.90  NRT\n",
       "5 5  Mymensingh 1960 5     29.6 23.2 2.4 73.45 1003.4 187    6.03  LTR\n",
       "6 6  Mymensingh 1960 6     28.2 24.1 2.0 84.03 1001.6 363   12.10  MHR"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "##CART for mymensignh data\n",
    "data<- read.csv(\"../input/mymensingh/Mymensingh.csv\")\n",
    "head(data)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "893ccf8e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:41.151547Z",
     "iopub.status.busy": "2022-05-08T16:38:41.150025Z",
     "iopub.status.idle": "2022-05-08T16:38:41.212648Z",
     "shell.execute_reply": "2022-05-08T16:38:41.210935Z"
    },
    "papermill": {
     "duration": 0.07191,
     "end_time": "2022-05-08T16:38:41.215487",
     "exception": false,
     "start_time": "2022-05-08T16:38:41.143577",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>TEM</th><th scope=col>DPT</th><th scope=col>WIS</th><th scope=col>HUM</th><th scope=col>SLP</th><th scope=col>RAN</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>16.9</td><td>11.3</td><td>2.0</td><td>73.39</td><td>1016.0</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>21.4</td><td>12.6</td><td>1.7</td><td>66.34</td><td>1013.0</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>24.1</td><td>14.9</td><td>2.3</td><td>64.13</td><td>1011.4</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>29.9</td><td>17.6</td><td>2.2</td><td>59.03</td><td>1007.1</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>29.6</td><td>23.2</td><td>2.4</td><td>73.45</td><td>1003.4</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>28.2</td><td>24.1</td><td>2.0</td><td>84.03</td><td>1001.6</td><td>MHR</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 6\n",
       "\\begin{tabular}{r|llllll}\n",
       "  & TEM & DPT & WIS & HUM & SLP & RAN\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 16.9 & 11.3 & 2.0 & 73.39 & 1016.0 & NRT\\\\\n",
       "\t2 & 21.4 & 12.6 & 1.7 & 66.34 & 1013.0 & NRT\\\\\n",
       "\t3 & 24.1 & 14.9 & 2.3 & 64.13 & 1011.4 & LTR\\\\\n",
       "\t4 & 29.9 & 17.6 & 2.2 & 59.03 & 1007.1 & NRT\\\\\n",
       "\t5 & 29.6 & 23.2 & 2.4 & 73.45 & 1003.4 & LTR\\\\\n",
       "\t6 & 28.2 & 24.1 & 2.0 & 84.03 & 1001.6 & MHR\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 6\n",
       "\n",
       "| <!--/--> | TEM &lt;dbl&gt; | DPT &lt;dbl&gt; | WIS &lt;dbl&gt; | HUM &lt;dbl&gt; | SLP &lt;dbl&gt; | RAN &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| 1 | 16.9 | 11.3 | 2.0 | 73.39 | 1016.0 | NRT |\n",
       "| 2 | 21.4 | 12.6 | 1.7 | 66.34 | 1013.0 | NRT |\n",
       "| 3 | 24.1 | 14.9 | 2.3 | 64.13 | 1011.4 | LTR |\n",
       "| 4 | 29.9 | 17.6 | 2.2 | 59.03 | 1007.1 | NRT |\n",
       "| 5 | 29.6 | 23.2 | 2.4 | 73.45 | 1003.4 | LTR |\n",
       "| 6 | 28.2 | 24.1 | 2.0 | 84.03 | 1001.6 | MHR |\n",
       "\n"
      ],
      "text/plain": [
       "  TEM  DPT  WIS HUM   SLP    RAN\n",
       "1 16.9 11.3 2.0 73.39 1016.0 NRT\n",
       "2 21.4 12.6 1.7 66.34 1013.0 NRT\n",
       "3 24.1 14.9 2.3 64.13 1011.4 LTR\n",
       "4 29.9 17.6 2.2 59.03 1007.1 NRT\n",
       "5 29.6 23.2 2.4 73.45 1003.4 LTR\n",
       "6 28.2 24.1 2.0 84.03 1001.6 MHR"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>672</li><li>6</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 672\n",
       "\\item 6\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 672\n",
       "2. 6\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 672   6"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>TEM</th><th scope=col>DPT</th><th scope=col>WIS</th><th scope=col>HUM</th><th scope=col>SLP</th><th scope=col>RAN</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>16.9</td><td>11.3</td><td>2.0</td><td>73.39</td><td>1016.0</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>21.4</td><td>12.6</td><td>1.7</td><td>66.34</td><td>1013.0</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>24.1</td><td>14.9</td><td>2.3</td><td>64.13</td><td>1011.4</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>29.9</td><td>17.6</td><td>2.2</td><td>59.03</td><td>1007.1</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>29.6</td><td>23.2</td><td>2.4</td><td>73.45</td><td>1003.4</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>28.2</td><td>24.1</td><td>2.0</td><td>84.03</td><td>1001.6</td><td>MHR</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 6\n",
       "\\begin{tabular}{r|llllll}\n",
       "  & TEM & DPT & WIS & HUM & SLP & RAN\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 16.9 & 11.3 & 2.0 & 73.39 & 1016.0 & NRT\\\\\n",
       "\t2 & 21.4 & 12.6 & 1.7 & 66.34 & 1013.0 & NRT\\\\\n",
       "\t3 & 24.1 & 14.9 & 2.3 & 64.13 & 1011.4 & LTR\\\\\n",
       "\t4 & 29.9 & 17.6 & 2.2 & 59.03 & 1007.1 & NRT\\\\\n",
       "\t5 & 29.6 & 23.2 & 2.4 & 73.45 & 1003.4 & LTR\\\\\n",
       "\t6 & 28.2 & 24.1 & 2.0 & 84.03 & 1001.6 & MHR\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 6\n",
       "\n",
       "| <!--/--> | TEM &lt;dbl&gt; | DPT &lt;dbl&gt; | WIS &lt;dbl&gt; | HUM &lt;dbl&gt; | SLP &lt;dbl&gt; | RAN &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| 1 | 16.9 | 11.3 | 2.0 | 73.39 | 1016.0 | NRT |\n",
       "| 2 | 21.4 | 12.6 | 1.7 | 66.34 | 1013.0 | NRT |\n",
       "| 3 | 24.1 | 14.9 | 2.3 | 64.13 | 1011.4 | LTR |\n",
       "| 4 | 29.9 | 17.6 | 2.2 | 59.03 | 1007.1 | NRT |\n",
       "| 5 | 29.6 | 23.2 | 2.4 | 73.45 | 1003.4 | LTR |\n",
       "| 6 | 28.2 | 24.1 | 2.0 | 84.03 | 1001.6 | MHR |\n",
       "\n"
      ],
      "text/plain": [
       "  TEM  DPT  WIS HUM   SLP    RAN\n",
       "1 16.9 11.3 2.0 73.39 1016.0 NRT\n",
       "2 21.4 12.6 1.7 66.34 1013.0 NRT\n",
       "3 24.1 14.9 2.3 64.13 1011.4 LTR\n",
       "4 29.9 17.6 2.2 59.03 1007.1 NRT\n",
       "5 29.6 23.2 2.4 73.45 1003.4 LTR\n",
       "6 28.2 24.1 2.0 84.03 1001.6 MHR"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "data[,c(1:4,10:11)]=NULL\n",
    "head(data)\n",
    "dim(data)\n",
    "DD=na.omit(data,1)\n",
    "head(DD)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "75b1967f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:41.230330Z",
     "iopub.status.busy": "2022-05-08T16:38:41.228770Z",
     "iopub.status.idle": "2022-05-08T16:38:41.256681Z",
     "shell.execute_reply": "2022-05-08T16:38:41.254351Z"
    },
    "papermill": {
     "duration": 0.038886,
     "end_time": "2022-05-08T16:38:41.259961",
     "exception": false,
     "start_time": "2022-05-08T16:38:41.221075",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t654 obs. of  6 variables:\n",
      " $ TEM: num  16.9 21.4 24.1 29.9 29.6 28.2 27.7 28.7 28 27 ...\n",
      " $ DPT: num  11.3 12.6 14.9 17.6 23.2 24.1 25.2 25.6 24.6 22.9 ...\n",
      " $ WIS: num  2 1.7 2.3 2.2 2.4 2 2.2 3 1.6 1.5 ...\n",
      " $ HUM: num  73.4 66.3 64.1 59 73.5 ...\n",
      " $ SLP: num  1016 1013 1011 1007 1003 ...\n",
      " $ RAN: Factor w/ 3 levels \"LTR\",\"MHR\",\"NRT\": 3 3 1 3 1 2 2 2 2 1 ...\n",
      " - attr(*, \"na.action\")= 'omit' Named int [1:18] 74 114 133 134 135 136 137 138 139 159 ...\n",
      "  ..- attr(*, \"names\")= chr [1:18] \"74\" \"114\" \"133\" \"134\" ...\n"
     ]
    }
   ],
   "source": [
    "DD$RAN=factor(DD$RAN)\n",
    "str(DD)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "3c67e268",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:41.275041Z",
     "iopub.status.busy": "2022-05-08T16:38:41.273294Z",
     "iopub.status.idle": "2022-05-08T16:38:41.305214Z",
     "shell.execute_reply": "2022-05-08T16:38:41.303351Z"
    },
    "papermill": {
     "duration": 0.041629,
     "end_time": "2022-05-08T16:38:41.307444",
     "exception": false,
     "start_time": "2022-05-08T16:38:41.265815",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>TEM</dt><dd>0</dd><dt>DPT</dt><dd>0</dd><dt>WIS</dt><dd>0</dd><dt>HUM</dt><dd>0</dd><dt>SLP</dt><dd>0</dd><dt>RAN</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[TEM] 0\n",
       "\\item[DPT] 0\n",
       "\\item[WIS] 0\n",
       "\\item[HUM] 0\n",
       "\\item[SLP] 0\n",
       "\\item[RAN] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "TEM\n",
       ":   0DPT\n",
       ":   0WIS\n",
       ":   0HUM\n",
       ":   0SLP\n",
       ":   0RAN\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "TEM DPT WIS HUM SLP RAN \n",
       "  0   0   0   0   0   0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>654</li><li>6</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 654\n",
       "\\item 6\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 654\n",
       "2. 6\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 654   6"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#==Check that no data is missing ===#\n",
    "##==HERE 1 for row, and 2 for column ===#\n",
    "#apply(DD,1,function(x) sum(is.na(x)))\n",
    "apply(DD,2,function(x) sum(is.na(x)))\n",
    "\n",
    "dim(DD)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "fad77d34",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:41.323037Z",
     "iopub.status.busy": "2022-05-08T16:38:41.321323Z",
     "iopub.status.idle": "2022-05-08T16:38:41.378621Z",
     "shell.execute_reply": "2022-05-08T16:38:41.376814Z"
    },
    "papermill": {
     "duration": 0.067634,
     "end_time": "2022-05-08T16:38:41.380971",
     "exception": false,
     "start_time": "2022-05-08T16:38:41.313337",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "490"
      ],
      "text/latex": [
       "490"
      ],
      "text/markdown": [
       "490"
      ],
      "text/plain": [
       "[1] 490"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "490"
      ],
      "text/latex": [
       "490"
      ],
      "text/markdown": [
       "490"
      ],
      "text/plain": [
       "[1] 490"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>TEM</th><th scope=col>DPT</th><th scope=col>WIS</th><th scope=col>HUM</th><th scope=col>SLP</th><th scope=col>RAN</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>290</th><td>21.1</td><td>10.9</td><td>2.8</td><td>61.10</td><td>1013.6</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>144</th><td>20.1</td><td>13.5</td><td>1.7</td><td>69.75</td><td>1015.1</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>234</th><td>28.7</td><td>24.7</td><td>5.5</td><td>85.07</td><td>1001.2</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>225</th><td>27.8</td><td>24.6</td><td>6.8</td><td>87.50</td><td>1005.2</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>14</th><td>17.8</td><td>11.3</td><td>1.6</td><td>75.46</td><td>1012.3</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>24.1</td><td>14.9</td><td>2.3</td><td>64.13</td><td>1011.4</td><td>LTR</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 6\n",
       "\\begin{tabular}{r|llllll}\n",
       "  & TEM & DPT & WIS & HUM & SLP & RAN\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <fct>\\\\\n",
       "\\hline\n",
       "\t290 & 21.1 & 10.9 & 2.8 & 61.10 & 1013.6 & NRT\\\\\n",
       "\t144 & 20.1 & 13.5 & 1.7 & 69.75 & 1015.1 & NRT\\\\\n",
       "\t234 & 28.7 & 24.7 & 5.5 & 85.07 & 1001.2 & LTR\\\\\n",
       "\t225 & 27.8 & 24.6 & 6.8 & 87.50 & 1005.2 & LTR\\\\\n",
       "\t14 & 17.8 & 11.3 & 1.6 & 75.46 & 1012.3 & NRT\\\\\n",
       "\t3 & 24.1 & 14.9 & 2.3 & 64.13 & 1011.4 & LTR\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 6\n",
       "\n",
       "| <!--/--> | TEM &lt;dbl&gt; | DPT &lt;dbl&gt; | WIS &lt;dbl&gt; | HUM &lt;dbl&gt; | SLP &lt;dbl&gt; | RAN &lt;fct&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| 290 | 21.1 | 10.9 | 2.8 | 61.10 | 1013.6 | NRT |\n",
       "| 144 | 20.1 | 13.5 | 1.7 | 69.75 | 1015.1 | NRT |\n",
       "| 234 | 28.7 | 24.7 | 5.5 | 85.07 | 1001.2 | LTR |\n",
       "| 225 | 27.8 | 24.6 | 6.8 | 87.50 | 1005.2 | LTR |\n",
       "| 14 | 17.8 | 11.3 | 1.6 | 75.46 | 1012.3 | NRT |\n",
       "| 3 | 24.1 | 14.9 | 2.3 | 64.13 | 1011.4 | LTR |\n",
       "\n"
      ],
      "text/plain": [
       "    TEM  DPT  WIS HUM   SLP    RAN\n",
       "290 21.1 10.9 2.8 61.10 1013.6 NRT\n",
       "144 20.1 13.5 1.7 69.75 1015.1 NRT\n",
       "234 28.7 24.7 5.5 85.07 1001.2 LTR\n",
       "225 27.8 24.6 6.8 87.50 1005.2 LTR\n",
       "14  17.8 11.3 1.6 75.46 1012.3 NRT\n",
       "3   24.1 14.9 2.3 64.13 1011.4 LTR"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>TEM</th><th scope=col>DPT</th><th scope=col>WIS</th><th scope=col>HUM</th><th scope=col>SLP</th><th scope=col>RAN</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>514</th><td>26.6</td><td>23.6</td><td>1.5</td><td>84.26</td><td>1010.2</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>83</th><td>24.0</td><td>18.3</td><td>0.1</td><td>76.67</td><td>1013.0</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>422</th><td>20.1</td><td>12.5</td><td>3.2</td><td>72.57</td><td>1013.4</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>504</th><td>18.9</td><td>15.0</td><td>1.4</td><td>80.19</td><td>1016.3</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>528</th><td>19.7</td><td>15.9</td><td>2.0</td><td>79.87</td><td>1015.6</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>527</th><td>22.9</td><td>18.5</td><td>1.7</td><td>80.87</td><td>1013.7</td><td>NRT</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 6\n",
       "\\begin{tabular}{r|llllll}\n",
       "  & TEM & DPT & WIS & HUM & SLP & RAN\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <fct>\\\\\n",
       "\\hline\n",
       "\t514 & 26.6 & 23.6 & 1.5 & 84.26 & 1010.2 & LTR\\\\\n",
       "\t83 & 24.0 & 18.3 & 0.1 & 76.67 & 1013.0 & NRT\\\\\n",
       "\t422 & 20.1 & 12.5 & 3.2 & 72.57 & 1013.4 & NRT\\\\\n",
       "\t504 & 18.9 & 15.0 & 1.4 & 80.19 & 1016.3 & NRT\\\\\n",
       "\t528 & 19.7 & 15.9 & 2.0 & 79.87 & 1015.6 & NRT\\\\\n",
       "\t527 & 22.9 & 18.5 & 1.7 & 80.87 & 1013.7 & NRT\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 6\n",
       "\n",
       "| <!--/--> | TEM &lt;dbl&gt; | DPT &lt;dbl&gt; | WIS &lt;dbl&gt; | HUM &lt;dbl&gt; | SLP &lt;dbl&gt; | RAN &lt;fct&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| 514 | 26.6 | 23.6 | 1.5 | 84.26 | 1010.2 | LTR |\n",
       "| 83 | 24.0 | 18.3 | 0.1 | 76.67 | 1013.0 | NRT |\n",
       "| 422 | 20.1 | 12.5 | 3.2 | 72.57 | 1013.4 | NRT |\n",
       "| 504 | 18.9 | 15.0 | 1.4 | 80.19 | 1016.3 | NRT |\n",
       "| 528 | 19.7 | 15.9 | 2.0 | 79.87 | 1015.6 | NRT |\n",
       "| 527 | 22.9 | 18.5 | 1.7 | 80.87 | 1013.7 | NRT |\n",
       "\n"
      ],
      "text/plain": [
       "    TEM  DPT  WIS HUM   SLP    RAN\n",
       "514 26.6 23.6 1.5 84.26 1010.2 LTR\n",
       "83  24.0 18.3 0.1 76.67 1013.0 NRT\n",
       "422 20.1 12.5 3.2 72.57 1013.4 NRT\n",
       "504 18.9 15.0 1.4 80.19 1016.3 NRT\n",
       "528 19.7 15.9 2.0 79.87 1015.6 NRT\n",
       "527 22.9 18.5 1.7 80.87 1013.7 NRT"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#==LIGHT RAIN (1-10 MM), MODERATE RAIN (11-22 MM), MODERATELY HEAVY RAIN (23-43 MM),\n",
    "#==HEAVY RAIN (44-88 MM), VERY HEAVY RAIN WITH GREATER THAN 88 MM\n",
    "\n",
    "set.seed(111112234)\n",
    "ID=sample(1:nrow(DD), round(nrow(DD)*0.75,0), replace=FALSE)\n",
    "\n",
    "length(ID)\n",
    "TR=data.frame(DD[ID,])  # Training Data\n",
    "TS=data.frame(DD[-ID,]) # Test Data\n",
    "nrow(TR)\n",
    "head(TR)\n",
    "tail(TR)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "f5bd06b9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:41.399425Z",
     "iopub.status.busy": "2022-05-08T16:38:41.397792Z",
     "iopub.status.idle": "2022-05-08T16:38:41.438357Z",
     "shell.execute_reply": "2022-05-08T16:38:41.435851Z"
    },
    "papermill": {
     "duration": 0.05193,
     "end_time": "2022-05-08T16:38:41.441269",
     "exception": false,
     "start_time": "2022-05-08T16:38:41.389339",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      "Classification tree:\n",
      "rpart(formula = RAN ~ ., data = TR, method = \"class\", control = rpart.control(cp = 0.007))\n",
      "\n",
      "Variables actually used in tree construction:\n",
      "[1] DPT HUM SLP TEM WIS\n",
      "\n",
      "Root node error: 294/490 = 0.6\n",
      "\n",
      "n= 490 \n",
      "\n",
      "         CP nsplit rel error  xerror     xstd\n",
      "1 0.4013605      0   1.00000 1.00000 0.036886\n",
      "2 0.1496599      1   0.59864 0.64286 0.036650\n",
      "3 0.0124717      2   0.44898 0.53061 0.035074\n",
      "4 0.0119048      5   0.41156 0.54422 0.035308\n",
      "5 0.0079365      8   0.37415 0.53401 0.035134\n",
      "6 0.0070000     13   0.33333 0.50340 0.034570\n"
     ]
    }
   ],
   "source": [
    "RT=rpart(RAN~., data=TR,method=\"class\",control=rpart.control(cp=0.007))\n",
    "printcp(RT)\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "0a23ea77",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:41.459280Z",
     "iopub.status.busy": "2022-05-08T16:38:41.457570Z",
     "iopub.status.idle": "2022-05-08T16:38:41.821192Z",
     "shell.execute_reply": "2022-05-08T16:38:41.818870Z"
    },
    "papermill": {
     "duration": 0.375782,
     "end_time": "2022-05-08T16:38:41.824225",
     "exception": false,
     "start_time": "2022-05-08T16:38:41.448443",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "dev.new(width=6,height=6)\n",
    "rpart.plot(RT,type=4,digits=2,fallen.leaves=FALSE,font=1,cex=0.6,main=\"CART Model\",cex.main=1)\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "ee1a6736",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:41.842102Z",
     "iopub.status.busy": "2022-05-08T16:38:41.840238Z",
     "iopub.status.idle": "2022-05-08T16:38:41.890717Z",
     "shell.execute_reply": "2022-05-08T16:38:41.888176Z"
    },
    "papermill": {
     "duration": 0.062683,
     "end_time": "2022-05-08T16:38:41.893958",
     "exception": false,
     "start_time": "2022-05-08T16:38:41.831275",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      "Classification tree:\n",
      "rpart(formula = RAN ~ ., data = TR, method = \"class\", control = rpart.control(cp = 0.007))\n",
      "\n",
      "Variables actually used in tree construction:\n",
      "[1] DPT HUM SLP TEM WIS\n",
      "\n",
      "Root node error: 294/490 = 0.6\n",
      "\n",
      "n= 490 \n",
      "\n",
      "         CP nsplit rel error  xerror     xstd\n",
      "1 0.4013605      0   1.00000 1.00000 0.036886\n",
      "2 0.1496599      1   0.59864 0.64286 0.036650\n",
      "3 0.0124717      2   0.44898 0.53061 0.035074\n",
      "4 0.0119048      5   0.41156 0.54422 0.035308\n",
      "5 0.0079365      8   0.37415 0.53401 0.035134\n",
      "6 0.0070000     13   0.33333 0.50340 0.034570\n",
      "\n",
      "Classification tree:\n",
      "rpart(formula = RAN ~ ., data = TR, method = \"class\", control = rpart.control(cp = 0.007))\n",
      "\n",
      "Variables actually used in tree construction:\n",
      "[1] DPT HUM SLP TEM WIS\n",
      "\n",
      "Root node error: 294/490 = 0.6\n",
      "\n",
      "n= 490 \n",
      "\n",
      "       CP nsplit rel error xerror   xstd\n",
      "1 0.40136      0     1.000  1.000 0.0369\n",
      "2 0.14966      1     0.599  0.643 0.0366\n",
      "3 0.01247      2     0.449  0.531 0.0351\n",
      "4 0.01190      5     0.412  0.544 0.0353\n",
      "5 0.00794      8     0.374  0.534 0.0351\n",
      "6 0.00700     13     0.333  0.503 0.0346\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 6 × 5 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>CP</th><th scope=col>nsplit</th><th scope=col>rel error</th><th scope=col>xerror</th><th scope=col>xstd</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0.401360544</td><td> 0</td><td>1.0000000</td><td>1.0000000</td><td>0.03688556</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0.149659864</td><td> 1</td><td>0.5986395</td><td>0.6428571</td><td>0.03664956</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>0.012471655</td><td> 2</td><td>0.4489796</td><td>0.5306122</td><td>0.03507439</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0.011904762</td><td> 5</td><td>0.4115646</td><td>0.5442177</td><td>0.03530788</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>0.007936508</td><td> 8</td><td>0.3741497</td><td>0.5340136</td><td>0.03513392</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0.007000000</td><td>13</td><td>0.3333333</td><td>0.5034014</td><td>0.03456993</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 6 × 5 of type dbl\n",
       "\\begin{tabular}{r|lllll}\n",
       "  & CP & nsplit & rel error & xerror & xstd\\\\\n",
       "\\hline\n",
       "\t1 & 0.401360544 &  0 & 1.0000000 & 1.0000000 & 0.03688556\\\\\n",
       "\t2 & 0.149659864 &  1 & 0.5986395 & 0.6428571 & 0.03664956\\\\\n",
       "\t3 & 0.012471655 &  2 & 0.4489796 & 0.5306122 & 0.03507439\\\\\n",
       "\t4 & 0.011904762 &  5 & 0.4115646 & 0.5442177 & 0.03530788\\\\\n",
       "\t5 & 0.007936508 &  8 & 0.3741497 & 0.5340136 & 0.03513392\\\\\n",
       "\t6 & 0.007000000 & 13 & 0.3333333 & 0.5034014 & 0.03456993\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 6 × 5 of type dbl\n",
       "\n",
       "| <!--/--> | CP | nsplit | rel error | xerror | xstd |\n",
       "|---|---|---|---|---|---|\n",
       "| 1 | 0.401360544 |  0 | 1.0000000 | 1.0000000 | 0.03688556 |\n",
       "| 2 | 0.149659864 |  1 | 0.5986395 | 0.6428571 | 0.03664956 |\n",
       "| 3 | 0.012471655 |  2 | 0.4489796 | 0.5306122 | 0.03507439 |\n",
       "| 4 | 0.011904762 |  5 | 0.4115646 | 0.5442177 | 0.03530788 |\n",
       "| 5 | 0.007936508 |  8 | 0.3741497 | 0.5340136 | 0.03513392 |\n",
       "| 6 | 0.007000000 | 13 | 0.3333333 | 0.5034014 | 0.03456993 |\n",
       "\n"
      ],
      "text/plain": [
       "  CP          nsplit rel error xerror    xstd      \n",
       "1 0.401360544  0     1.0000000 1.0000000 0.03688556\n",
       "2 0.149659864  1     0.5986395 0.6428571 0.03664956\n",
       "3 0.012471655  2     0.4489796 0.5306122 0.03507439\n",
       "4 0.011904762  5     0.4115646 0.5442177 0.03530788\n",
       "5 0.007936508  8     0.3741497 0.5340136 0.03513392\n",
       "6 0.007000000 13     0.3333333 0.5034014 0.03456993"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0.007"
      ],
      "text/latex": [
       "0.007"
      ],
      "text/markdown": [
       "0.007"
      ],
      "text/plain": [
       "[1] 0.007"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "printcp(RT)\n",
    "printcp(RT, digits = getOption(\"digits\") - 4)\n",
    "\n",
    "RT$cptable\n",
    "bestcp =RT$cptable[which.min(RT$cptable[,\"xerror\"]),\"CP\"]\n",
    "bestcp\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "e5bdb11b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:41.913370Z",
     "iopub.status.busy": "2022-05-08T16:38:41.911256Z",
     "iopub.status.idle": "2022-05-08T16:38:42.099473Z",
     "shell.execute_reply": "2022-05-08T16:38:42.097193Z"
    },
    "papermill": {
     "duration": 0.200883,
     "end_time": "2022-05-08T16:38:42.102446",
     "exception": false,
     "start_time": "2022-05-08T16:38:41.901563",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "n= 490 \n",
       "\n",
       "node), split, n, loss, yval, (yprob)\n",
       "      * denotes terminal node\n",
       "\n",
       "  1) root 490 294 NRT (0.375510204 0.224489796 0.400000000)  \n",
       "    2) DPT>=20.55 263 127 LTR (0.517110266 0.414448669 0.068441065)  \n",
       "      4) HUM< 84.545 129  35 LTR (0.728682171 0.178294574 0.093023256)  \n",
       "        8) WIS>=1.15 118  29 LTR (0.754237288 0.194915254 0.050847458)  \n",
       "         16) SLP>=1005.55 56  10 LTR (0.821428571 0.071428571 0.107142857) *\n",
       "         17) SLP< 1005.55 62  19 LTR (0.693548387 0.306451613 0.000000000)  \n",
       "           34) TEM>=27.8 52  11 LTR (0.788461538 0.211538462 0.000000000)  \n",
       "             68) SLP>=1002.4 26   2 LTR (0.923076923 0.076923077 0.000000000) *\n",
       "             69) SLP< 1002.4 26   9 LTR (0.653846154 0.346153846 0.000000000)  \n",
       "              138) TEM>=29.05 17   2 LTR (0.882352941 0.117647059 0.000000000) *\n",
       "              139) TEM< 29.05 9   2 MHR (0.222222222 0.777777778 0.000000000) *\n",
       "           35) TEM< 27.8 10   2 MHR (0.200000000 0.800000000 0.000000000) *\n",
       "        9) WIS< 1.15 11   5 NRT (0.454545455 0.000000000 0.545454545) *\n",
       "      5) HUM>=84.545 134  48 MHR (0.313432836 0.641791045 0.044776119)  \n",
       "       10) HUM< 86.045 53  26 LTR (0.509433962 0.490566038 0.000000000)  \n",
       "         20) HUM>=85.69 10   2 LTR (0.800000000 0.200000000 0.000000000) *\n",
       "         21) HUM< 85.69 43  19 MHR (0.441860465 0.558139535 0.000000000)  \n",
       "           42) WIS< 2.25 15   5 LTR (0.666666667 0.333333333 0.000000000) *\n",
       "           43) WIS>=2.25 28   9 MHR (0.321428571 0.678571429 0.000000000) *\n",
       "       11) HUM>=86.045 81  21 MHR (0.185185185 0.740740741 0.074074074) *\n",
       "    3) DPT< 20.55 227  49 NRT (0.211453744 0.004405286 0.784140969)  \n",
       "      6) SLP< 1012.1 64  32 NRT (0.484375000 0.015625000 0.500000000)  \n",
       "       12) TEM>=26 26  10 LTR (0.615384615 0.038461538 0.346153846) *\n",
       "       13) TEM< 26 38  15 NRT (0.394736842 0.000000000 0.605263158)  \n",
       "         26) SLP>=1011.15 14   5 LTR (0.642857143 0.000000000 0.357142857) *\n",
       "         27) SLP< 1011.15 24   6 NRT (0.250000000 0.000000000 0.750000000) *\n",
       "      7) SLP>=1012.1 163  17 NRT (0.104294479 0.000000000 0.895705521) *"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "###Prune the tree using the best cp.\n",
    "tree.pruned = prune(RT, cp = bestcp)\n",
    "tree.pruned\n",
    "\n",
    "\n",
    "dev.new(width=6,height=6)\n",
    "rpart.plot(tree.pruned,type=4,digits=2,fallen.leaves=FALSE,font=1,cex=0.6,main=\"CART Model\",cex.main=1)\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "5f48be5a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:42.121680Z",
     "iopub.status.busy": "2022-05-08T16:38:42.119756Z",
     "iopub.status.idle": "2022-05-08T16:38:42.158625Z",
     "shell.execute_reply": "2022-05-08T16:38:42.156605Z"
    },
    "papermill": {
     "duration": 0.050805,
     "end_time": "2022-05-08T16:38:42.161028",
     "exception": false,
     "start_time": "2022-05-08T16:38:42.110223",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "     Pr\n",
       "      LTR MHR NRT\n",
       "  LTR 128  28  28\n",
       "  MHR  16  94   0\n",
       "  NRT  20   6 170"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0.8"
      ],
      "text/latex": [
       "0.8"
      ],
      "text/markdown": [
       "0.8"
      ],
      "text/plain": [
       "[1] 0.8"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0.2"
      ],
      "text/latex": [
       "0.2"
      ],
      "text/markdown": [
       "0.2"
      ],
      "text/plain": [
       "[1] 0.2"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "Pr=predict(RT, data=TR[,-6],type=\"class\")\n",
    "Tr=table(TR$RAN,Pr)\n",
    "A=sum(diag(Tr))/sum(Tr)\n",
    "Tr\n",
    "A\n",
    "1-A\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "518f1162",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-08T16:38:42.181169Z",
     "iopub.status.busy": "2022-05-08T16:38:42.179250Z",
     "iopub.status.idle": "2022-05-08T16:38:42.219908Z",
     "shell.execute_reply": "2022-05-08T16:38:42.217861Z"
    },
    "papermill": {
     "duration": 0.053595,
     "end_time": "2022-05-08T16:38:42.222529",
     "exception": false,
     "start_time": "2022-05-08T16:38:42.168934",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "     PRS\n",
       "      LTR MHR NRT\n",
       "  LTR  36  17  13\n",
       "  MHR  11  37   0\n",
       "  NRT  10   0  40"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0.689024390243902"
      ],
      "text/latex": [
       "0.689024390243902"
      ],
      "text/markdown": [
       "0.689024390243902"
      ],
      "text/plain": [
       "[1] 0.6890244"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0.310975609756098"
      ],
      "text/latex": [
       "0.310975609756098"
      ],
      "text/markdown": [
       "0.310975609756098"
      ],
      "text/plain": [
       "[1] 0.3109756"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "PRS=predict(RT, newdata=TS[,-6],type=\"class\")\n",
    "TSS=table(TS$RAN,PRS)\n",
    "ASS=sum(diag(TSS))/sum(TSS)\n",
    "TSS\n",
    "ASS\n",
    "1-ASS\n"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 6.820861,
   "end_time": "2022-05-08T16:38:42.352867",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-05-08T16:38:35.532006",
   "version": "2.3.4"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
